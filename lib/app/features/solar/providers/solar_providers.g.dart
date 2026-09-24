// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Solars)
final solarsProvider = SolarsProvider._();

final class SolarsProvider extends $AsyncNotifierProvider<Solars, List<Solar>> {
  SolarsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'solarsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$solarsHash();

  @$internal
  @override
  Solars create() => Solars();
}

String _$solarsHash() => r'69da5e9c239166cf8563db9aa60c6058514cb33f';

abstract class _$Solars extends $AsyncNotifier<List<Solar>> {
  FutureOr<List<Solar>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Solar>>, List<Solar>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Solar>>, List<Solar>>,
              AsyncValue<List<Solar>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
