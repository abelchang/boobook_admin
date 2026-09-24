// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_year_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SolarYear)
final solarYearProvider = SolarYearProvider._();

final class SolarYearProvider extends $NotifierProvider<SolarYear, int> {
  SolarYearProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'solarYearProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$solarYearHash();

  @$internal
  @override
  SolarYear create() => SolarYear();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$solarYearHash() => r'8af311e4b96672a7c8407424d2b473b82e4a038d';

abstract class _$SolarYear extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
