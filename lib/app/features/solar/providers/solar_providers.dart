// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/solar.dart';
import '../repository/solar_repository_impl.dart';
import 'solar_year_provider.dart';

part 'solar_providers.g.dart';

@riverpod
class Solars extends _$Solars {
  @override
  Future<List<Solar>> build() async {
    final year = ref.watch(solarYearProvider);
    final repository = ref.read(solarRepositoryProvider);
    final solars = await repository.getSolars(year);
    solars.sort((a, b) => a.date.compareTo(b.date));
    return solars;
  }

  /// 以天文演算法整批產生指定年份的 24 個節氣（覆寫該年，為「自動維護」的唯一入口）。
  /// 成功後直接以回傳結果取代列表；失敗回傳 false，保留列表由 UI 提示。
  Future<bool> generateYear(int year) async {
    final repository = ref.read(solarRepositoryProvider);
    try {
      final solars = await repository.generateYear(year);
      if (!ref.mounted) return false;
      solars.sort((a, b) => a.date.compareTo(b.date));
      state = AsyncValue.data(solars);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 新增或更新單筆節氣。成功回傳 true（並同步更新本地列表）；失敗回傳 false，保留列表由 UI 提示。
  Future<bool> store(Solar day) async {
    final repository = ref.read(solarRepositoryProvider);
    try {
      day = await repository.store(day);
      if (!ref.mounted) return false;

      final solars = state.value ?? [];
      final index = solars.indexWhere((h) => h.id == day.id);

      if (index != -1) {
        solars[index] = day;
      } else {
        solars.add(day);
      }
      solars.sort((a, b) => a.date.compareTo(b.date));
      state = AsyncValue.data(solars);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 刪除單筆節氣。成功回傳 true（並同步更新本地列表）；失敗回傳 false，保留列表由 UI 提示。
  Future<bool> destroy(int id) async {
    final repository = ref.read(solarRepositoryProvider);
    try {
      final result = await repository.destroy(id);
      if (!ref.mounted) return false;
      if (!result) return false;
      final solars = state.value ?? [];
      final index = solars.indexWhere((h) => h.id == id);
      if (index != -1) {
        solars.removeAt(index);
        state = AsyncValue.data(solars);
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}