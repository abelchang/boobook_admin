// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/holiday.dart';
import '../repository/holiday_repository_impl.dart';
import 'year_provider.dart';

part 'holiday_providers.g.dart';

@riverpod
class Holidays extends _$Holidays {
  @override
  Future<List<Holiday>> build() async {
    final year = ref.watch(yearProvider);
    final repository = ref.read(holidayRepositoryProvider);
    final holidays = await repository.getHolidays(year);
    holidays.sort((a, b) => a.date.compareTo(b.date));
    return holidays;
  }

  /// 重新向後端抓取目前年份（政府資料匯入完成後呼叫，讓主列表立即反映新資料）。
  void refresh() => ref.invalidateSelf();

  /// 刪除單筆假日。成功回傳 true（並同步更新本地列表）；失敗回傳 false，保留列表由 UI 提示。
  Future<bool> destroy(int id) async {
    final repository = ref.read(holidayRepositoryProvider);
    try {
      final result = await repository.destroy(id);
      if (!ref.mounted) return false;
      if (!result) return false;
      final holidays = state.value ?? [];
      final index = holidays.indexWhere((h) => h.id == id);
      if (index != -1) {
        holidays.removeAt(index);
        state = AsyncValue.data(holidays);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 新增或更新單筆假日。成功回傳 true（並同步更新本地列表）；失敗回傳 false，保留列表由 UI 提示。
  Future<bool> store(Holiday day) async {
    final repository = ref.read(holidayRepositoryProvider);
    try {
      day = await repository.store(day);
      if (!ref.mounted) return false;

      final holidays = state.value ?? [];
      final index = holidays.indexWhere((h) => h.id == day.id);

      if (index != -1) {
        holidays[index] = day;
      } else {
        holidays.add(day);
      }
      holidays.sort((a, b) => a.date.compareTo(b.date));
      state = AsyncValue.data(holidays);
      return true;
    } catch (_) {
      return false;
    }
  }
}