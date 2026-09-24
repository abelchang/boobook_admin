import 'package:boobook_admin/app/features/solar/model/solar.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_providers.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_year_provider.dart';
import 'package:boobook_admin/app/features/solar/repository/solar_repository.dart';
import 'package:boobook_admin/app/features/solar/repository/solar_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 記憶體版假 repository，驗證 Solars notifier 的 store / destroy 邏輯。
class _FakeSolarRepository implements SolarRepository {
  final List<Solar> items = [];
  int _nextId = 1;

  @override
  Future<List<Solar>> getSolars(int year) async {
    return items.where((s) => s.date.year == year).toList();
  }

  @override
  Future<List<Solar>> generateYear(int year) async {
    // 產生 3 筆簡化樣本，取代該年既有資料
    items.removeWhere((s) => s.date.year == year);
    final generated = [
      Solar(id: _nextId++, date: DateTime(year, 1, 5), name: '小寒'),
      Solar(id: _nextId++, date: DateTime(year, 4, 5), name: '清明'),
      Solar(id: _nextId++, date: DateTime(year, 12, 22), name: '冬至'),
    ];
    items.addAll(generated);
    return generated;
  }

  @override
  Future<Solar> store(Solar day) async {
    if (day.id == null) {
      final created = day.copyWith(id: _nextId++);
      items.add(created);
      return created;
    }
    final index = items.indexWhere((s) => s.id == day.id);
    items[index] = day;
    return day;
  }

  @override
  Future<bool> destroy(int id) async {
    items.removeWhere((s) => s.id == id);
    return true;
  }
}

void main() {
  late _FakeSolarRepository fake;
  late ProviderContainer container;

  setUp(() {
    fake = _FakeSolarRepository();
    container = ProviderContainer(
      overrides: [
        solarRepositoryProvider.overrideWithValue(fake),
      ],
    );
    addTearDown(container.dispose);
    // 固定年份，避免測試依賴「今年」。
    container.read(solarYearProvider.notifier).state = 2023;
  });

  test('build 依年份抓取並依日期排序', () async {
    fake.items.addAll([
      Solar(id: 1, date: DateTime(2023, 12, 22), name: '冬至'),
      Solar(id: 2, date: DateTime(2023, 1, 5), name: '小寒'),
      Solar(id: 3, date: DateTime(2024, 1, 6), name: '小寒明年'),
    ]);

    final solars = await container.read(solarsProvider.future);

    expect(solars.map((s) => s.name), ['小寒', '冬至']);
  });

  test('store 新增一筆後同步到列表', () async {
    final ok = await container
        .read(solarsProvider.notifier)
        .store(Solar(date: DateTime(2023, 5, 6), name: '立夏'));

    expect(ok, isTrue);
    final solars = await container.read(solarsProvider.future);
    expect(solars.map((s) => s.name), contains('立夏'));
    expect(fake.items, hasLength(1));
  });

  test('store 編輯既有節氣（同 id）時原位更新', () async {
    await container
        .read(solarsProvider.notifier)
        .store(Solar(date: DateTime(2023, 5, 6), name: '立夏'));
    final saved = (await container.read(solarsProvider.future))
        .firstWhere((s) => s.name == '立夏');

    final ok = await container
        .read(solarsProvider.notifier)
        .store(saved.copyWith(description: '夏季開始'));

    expect(ok, isTrue);
    final solars = await container.read(solarsProvider.future);
    expect(solars, hasLength(1));
    final updated = solars.firstWhere((s) => s.id == saved.id);
    expect(updated.description, '夏季開始');
  });

  test('generateYear 整批產生並覆寫列表', () async {
    await container
        .read(solarsProvider.notifier)
        .store(Solar(date: DateTime(2023, 5, 6), name: '立夏'));
    expect((await container.read(solarsProvider.future)).length, 1);

    final ok =
        await container.read(solarsProvider.notifier).generateYear(2023);

    expect(ok, isTrue);
    final solars = await container.read(solarsProvider.future);
    expect(solars.map((s) => s.name), ['小寒', '清明', '冬至']);
  });

  test('destroy 刪除後同步移除列表', () async {
    await container
        .read(solarsProvider.notifier)
        .store(Solar(date: DateTime(2023, 5, 6), name: '立夏'));
    final saved = (await container.read(solarsProvider.future))
        .firstWhere((s) => s.name == '立夏');

    final ok =
        await container.read(solarsProvider.notifier).destroy(saved.id!);

    expect(ok, isTrue);
    final solars = await container.read(solarsProvider.future);
    expect(solars, isEmpty);
    expect(fake.items, isEmpty);
  });
}