import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/solar/model/solar.dart';
import 'package:boobook_admin/app/features/solar/repository/solar_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

/// 以假 Network（不連真實後端）測試 SolarRepositoryImpl 的 mapping 邏輯。
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
  group('SolarRepositoryImpl', () {
    test('getSolars 解析 success + solars 列表', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {
            'success': true,
            'solars': [
              {
                'id': 1,
                'date': '2023-01-05',
                'name': '小寒',
                'description': '二十四節氣之一',
                'generated_at': '2023-11-30T13:45:00.000Z',
              },
            ],
          };
        },
      );
      final repo = SolarRepositoryImpl(network: fake);

      final solars = await repo.getSolars(2023);

      expect(receivedBodies, [
        {'thisYear': 2023},
      ]);
      expect(solars, hasLength(1));
      expect(solars.first.id, 1);
      expect(solars.first.date, DateTime(2023, 1, 5));
      expect(solars.first.name, '小寒');
      expect(solars.first.description, '二十四節氣之一');
      expect(solars.first.generatedAt, DateTime.utc(2023, 11, 30, 13, 45));
    });

    test('getSolars success=false 時拋錯', () async {
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async => {'success': false},
      );
      final repo = SolarRepositoryImpl(network: fake);

      expect(repo.getSolars(2023), throwsException);
    });

    test('store 送出 solar 並回傳伺服器回寫的資料', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {
            'success': true,
            'solar': {
              'id': 3,
              'date': '2023-04-05',
              'name': '清明',
              'description': '',
            },
          };
        },
      );
      final repo = SolarRepositoryImpl(network: fake);

      final day = Solar(date: DateTime(2023, 4, 5), name: '清明');
      final saved = await repo.store(day);

      final body = receivedBodies.single as Map<String, Object?>;
      expect(body.keys, ['solar']);
      expect(body['solar'], isA<Solar>());
      expect(saved.id, 3);
      expect(saved.name, '清明');
    });

    test('generateYear 送出年份並解析整批產生的 solars', () async {
      final receivedBodies = <Object?>[];
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async {
          receivedBodies.add(data);
          return {
            'success': true,
            'solars': [
              {
                'id': 101,
                'date': '2026-01-05',
                'name': '小寒',
                'description': '',
              },
              {
                'id': 102,
                'date': '2026-01-20',
                'name': '大寒',
                'description': '',
              },
            ],
          };
        },
      );
      final repo = SolarRepositoryImpl(network: fake);

      final solars = await repo.generateYear(2026);

      expect(receivedBodies, [
        {'thisYear': 2026},
      ]);
      expect(solars, hasLength(2));
      expect(solars.first.id, 101);
      expect(solars.first.name, '小寒');
      expect(solars.last.date, DateTime(2026, 1, 20));
    });

    test('generateYear success=false 時拋錯', () async {
      final fake = _FakeNetwork(
        onPost: (apiUrl, data) async => {'success': false},
      );
      final repo = SolarRepositoryImpl(network: fake);

      expect(repo.generateYear(2026), throwsException);
    });

    test('destroy 刪除成功回傳 true，失敗拋錯', () async {
      final fake = _FakeNetwork(
        onDelete: (apiUrl) async => {'success': true},
      );
      final repo = SolarRepositoryImpl(network: fake);

      expect(await repo.destroy(5), isTrue);

      final failing = _FakeNetwork(
        onDelete: (apiUrl) async => {'success': false},
      );
      final repo2 = SolarRepositoryImpl(network: failing);
      expect(repo2.destroy(5), throwsException);
    });
  });
}