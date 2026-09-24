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

  Future<void> desroy(int id) async {
    final repository = ref.read(holidayRepositoryProvider);
    try {
      bool result = await repository.destroy(id);
      if (!ref.mounted) return;
      if (result) {
        final holidays = state.value ?? [];
        final index = holidays.indexWhere((h) => h.id == id);
        if (index != -1) {
          holidays.removeAt(index);
          state = AsyncValue.data(holidays);
        }
      }
    } catch (err, stack) {
      if (ref.mounted) {
        state = AsyncValue.error(err, stack);
      }
    }
  }

  Future<void> store(Holiday day) async {
    final repository = ref.read(holidayRepositoryProvider);
    try {
      day = await repository.store(day);
      if (!ref.mounted) return;

      final holidays = state.value ?? [];
      final index = holidays.indexWhere((h) => h.id == day.id);

      if (index != -1) {
        holidays[index] = day.copyWith();
      } else {
        holidays.add(day);
      }
      holidays.sort((a, b) => a.date.compareTo(b.date));
      state = AsyncValue.data(holidays);
    } catch (err, stack) {
      if (ref.mounted) {
        state = AsyncValue.error(err, stack);
      }
    }
  }
}
