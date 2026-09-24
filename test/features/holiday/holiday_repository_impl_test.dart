import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

/// 以假 Network（不連真實後端）測試 HolidayRepositoryImpl 的 mapping 邏輯。
class _FakeNetwork implements Network {
  _FakeNetwork({this.onPost, this.onDelete});

  final Future<Object?> Function(String apiUrl, Object? data)? onPost;
  final Future<Object?> Function(String apiUrl)? onDelete;

  @override
  Future<dynamic> postData(Object? data, String apiUrl) async {
    return onPost?.call(apiUrl, data) ?? <String, Object?>{};
  }

  @override
  Future<dynamic> deleData(String apiUrl) async {
    return onDelete?.call(apiUrl) ?? <String, Object?>{};
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError('not used: ${invocation.memberName}');
  }
}

void main() {
  group('HolidayRepositoryImpl', () {
    test('getHolidays 解析 success + holidays 列表', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {
            'success': true,
            'holidays': [
              {
                'id': 1,
                'date': '2023-01-01',
                'name': '元旦',
                'isHoliday': 1,
                'holidayCategory': '國定假日',
                'description': '開國紀念日',
                'tep': 1,
              },
            ],
          };
        },
      );
      final repo = HolidayRepositoryImpl(network: fake);

      final holidays = await repo.getHolidays(2023);

      expect(receivedBodies, [
        {'thisYear': 2023},
      ]);
      expect(holidays, hasLength(1));
      expect(holidays.first.id, 1);
      expect(holidays.first.date, DateTime(2023, 1, 1));
      expect(holidays.first.name, '元旦');
      expect(holidays.first.isHoliday, isTrue);
      expect(holidays.first.tep, isTrue);
    });

    test('getHolidays success=false 時拋錯', () async {
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async => {'success': false},
      );
      final repo = HolidayRepositoryImpl(network: fake);

      expect(repo.getHolidays(2023), throwsException);
    });

    test('store 送出 holiday 並回傳伺服器回寫的資料', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {
            'success': true,
            'holiday': {
              'id': 7,
              'date': '2023-02-28',
              'name': '和平紀念日',
              'isHoliday': 1,
              'holidayCategory': '',
              'description': '',
              'tep': 0,
            },
          };
        },
      );
      final repo = HolidayRepositoryImpl(network: fake);

      final day = Holiday(
        date: DateTime(2023, 2, 28),
        name: '和平紀念日',
        isHoliday: true,
      );
      final saved = await repo.store(day);

      final body = receivedBodies.single as Map<String, Object?>;
      expect(body.keys, ['holiday']);
      expect(body['holiday'], isA<Holiday>());
      expect(saved.id, 7);
      expect(saved.tep, isFalse);
    });

    test('storeList 成功送批次並回傳 true', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {'success': true};
        },
      );
      final repo = HolidayRepositoryImpl(network: fake);

      final ok = await repo.storeList([
        Holiday(date: DateTime(2023, 10, 10), name: '國慶日', isHoliday: true),
      ]);

      expect(ok, isTrue);
      final body = receivedBodies.single as Map<String, Object?>;
      expect(body['holidayList'], isA<List<Holiday>>());
    });

    test('destroy 刪除成功回傳 true，失敗拋錯', () async {
      final fake = _FakeNetwork(
        onDelete: (apiUrl) async => {'success': true},
      );
      final repo = HolidayRepositoryImpl(network: fake);

      expect(await repo.destroy(5), isTrue);

      final failing = _FakeNetwork(
        onDelete: (apiUrl) async => {'success': false},
      );
      final repo2 = HolidayRepositoryImpl(network: failing);
      expect(repo2.destroy(5), throwsException);
    });
  });
}