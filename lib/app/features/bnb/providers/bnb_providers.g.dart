// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bnb_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Bnbs)
final bnbsProvider = BnbsProvider._();

final class BnbsProvider extends $AsyncNotifierProvider<Bnbs, List<Bnb>> {
  BnbsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bnbsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bnbsHash();

  @$internal
  @override
  Bnbs create() => Bnbs();
}

String _$bnbsHash() => r'365dcbb583a275b0a79eb90060325bc62e25a83c';

abstract class _$Bnbs extends $AsyncNotifier<List<Bnb>> {
  FutureOr<List<Bnb>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Bnb>>, List<Bnb>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Bnb>>, List<Bnb>>,
              AsyncValue<List<Bnb>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
