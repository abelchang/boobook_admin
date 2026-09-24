// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_gov_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GovHolidays)
final govHolidaysProvider = GovHolidaysProvider._();

final class GovHolidaysProvider
    extends $AsyncNotifierProvider<GovHolidays, List<Holiday>> {
  GovHolidaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'govHolidaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$govHolidaysHash();

  @$internal
  @override
  GovHolidays create() => GovHolidays();
}

String _$govHolidaysHash() => r'ad680b0df86037da31a1414b2e0fffaceed8d1cf';

abstract class _$GovHolidays extends $AsyncNotifier<List<Holiday>> {
  FutureOr<List<Holiday>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Holiday>>, List<Holiday>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Holiday>>, List<Holiday>>,
              AsyncValue<List<Holiday>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
