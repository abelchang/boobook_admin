// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Year)
final yearProvider = YearProvider._();

final class YearProvider extends $NotifierProvider<Year, int> {
  YearProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'yearProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$yearHash();

  @$internal
  @override
  Year create() => Year();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$yearHash() => r'2161acc20dc8a0f0a36029a1c5ea969b0e3f06aa';

abstract class _$Year extends $Notifier<int> {
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
