import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'solar_year_provider.g.dart';

@riverpod
class SolarYear extends _$SolarYear {
  @override
  int build() => DateTime.now().year;

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
}