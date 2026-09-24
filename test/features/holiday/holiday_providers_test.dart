import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/providers/holiday_providers.dart';
import 'package:boobook_admin/app/features/holiday/providers/year_provider.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 記憶體版假 repository，驗證 Holidays notifier 的 store / destroy / refresh 邏輯。
class _FakeHolidayRepository implements HolidayRepository {
  final List<Holiday> items = [];
  int _nextId = 1;
  int getHolidaysCalls = 0;

  @override
  Future<List<Holiday>> getHolidays(int year) async {
    getHolidaysCalls++;
    return items.where((h) => h.date.year == year).toList();
  }

  @override
  Future<Holiday> store(Holiday day) async {
    if (day.id == null) {
      final created = day.copyWith(id: _nextId++);
      items.add(created);
      return created;
    }
    final index = items.indexWhere((h) => h.id == day.id);
    items[index] = day;
    return day;
  }

  @override
  Future<bool> storeList(List<Holiday> holidays) async {
    items.addAll(holidays);
    return true;
  }

  @override
  Future<bool> destroy(int id) async {
    items.removeWhere((h) => h.id == id);
    return true;
  }
}

void main() {
  late _FakeHolidayRepository fake;
  late ProviderContainer container;

  setUp(() {
    fake = _FakeHolidayRepository();
    container = ProviderContainer(
      overrides: [
        holidayRepositoryProvider.overrideWithValue(fake),
      ],
    );
    addTearDown(container.dispose);
    // 固定年份，避免測試依賴「今年」。
    container.read(yearProvider.notifier).state = 2023;
  });

  test('build 依年份抓取並依日期排序', () async {
    fake.items.addAll([
      Holiday(id: 1, date: DateTime(2023, 12, 31), name: '跨年', isHoliday: true),
      Holiday(id: 2, date: DateTime(2023, 1, 1), name: '元旦', isHoliday: true),
      Holiday(id: 3, date: DateTime(2024, 1, 1), name: '明年元旦', isHoliday: true),
    ]);

    final holidays = await container.read(holidaysProvider.future);

    expect(holidays.map((h) => h.name), ['元旦', '跨年']);
  });

  test('store 新增一筆後同步到列表', () async {
    final ok = await container
        .read(holidaysProvider.notifier)
        .store(Holiday(date: DateTime(2023, 5, 1), name: '勞動節', isHoliday: true));

    expect(ok, isTrue);
    final holidays = await container.read(holidaysProvider.future);
    expect(holidays.map((h) => h.name), contains('勞動節'));
    expect(fake.items, hasLength(1));
  });

  test('store 編輯既有假日（同 id）時原位更新', () async {
    await container
        .read(holidaysProvider.notifier)
        .store(Holiday(date: DateTime(2023, 5, 1), name: '勞動節', isHoliday: true));
    final saved = (await container.read(holidaysProvider.future))
        .firstWhere((h) => h.name == '勞動節');

    final ok = await container.read(holidaysProvider.notifier).store(
          saved.copyWith(description: '勞工節', tep: true),
        );

    expect(ok, isTrue);
    final holidays = await container.read(holidaysProvider.future);
    expect(holidays, hasLength(1));
    final updated = holidays.firstWhere((h) => h.id == saved.id);
    expect(updated.description, '勞工節');
    expect(updated.tep, isTrue);
  });

  test('destroy 刪除後同步移除列表', () async {
    await container
        .read(holidaysProvider.notifier)
        .store(Holiday(date: DateTime(2023, 5, 1), name: '勞動節', isHoliday: true));
    final saved = (await container.read(holidaysProvider.future))
        .firstWhere((h) => h.name == '勞動節');

    final ok =
        await container.read(holidaysProvider.notifier).destroy(saved.id!);

    expect(ok, isTrue);
    final holidays = await container.read(holidaysProvider.future);
    expect(holidays, isEmpty);
    expect(fake.items, isEmpty);
  });

  test('refresh 會重新向 repository 抓取資料', () async {
    await container.read(holidaysProvider.future);
    final callsBefore = fake.getHolidaysCalls;
    expect(callsBefore, 1);

    container.read(holidaysProvider.notifier).refresh();
    await container.read(holidaysProvider.future);

    expect(fake.getHolidaysCalls, greaterThan(callsBefore));
  });
}