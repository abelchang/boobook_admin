import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'year_provider.g.dart';

@riverpod
class Year extends _$Year {
  @override
  int build() => DateTime.now().year;

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
}
