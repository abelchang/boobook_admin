// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Holidays)
final holidaysProvider = HolidaysProvider._();

final class HolidaysProvider
    extends $AsyncNotifierProvider<Holidays, List<Holiday>> {
  HolidaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'holidaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$holidaysHash();

  @$internal
  @override
  Holidays create() => Holidays();
}

String _$holidaysHash() => r'c42502cdca71b43182c00e92dd01724a49ce448b';

abstract class _$Holidays extends $AsyncNotifier<List<Holiday>> {
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
