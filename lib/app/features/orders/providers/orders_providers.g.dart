// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ordersHash() => r'4ec06b4382fefe6c6142474c5273e5554b1e8e30';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Orders extends BuildlessAutoDisposeAsyncNotifier<List<Order>> {
  late final int bnbId;

  FutureOr<List<Order>> build(
    int bnbId,
  );
}

/// See also [Orders].
@ProviderFor(Orders)
const ordersProvider = OrdersFamily();

/// See also [Orders].
class OrdersFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [Orders].
  const OrdersFamily();

  /// See also [Orders].
  OrdersProvider call(
    int bnbId,
  ) {
    return OrdersProvider(
      bnbId,
    );
  }

  @override
  OrdersProvider getProviderOverride(
    covariant OrdersProvider provider,
  ) {
    return call(
      provider.bnbId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ordersProvider';
}

/// See also [Orders].
class OrdersProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Orders, List<Order>> {
  /// See also [Orders].
  OrdersProvider(
    int bnbId,
  ) : this._internal(
          () => Orders()..bnbId = bnbId,
          from: ordersProvider,
          name: r'ordersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ordersHash,
          dependencies: OrdersFamily._dependencies,
          allTransitiveDependencies: OrdersFamily._allTransitiveDependencies,
          bnbId: bnbId,
        );

  OrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bnbId,
  }) : super.internal();

  final int bnbId;

  @override
  FutureOr<List<Order>> runNotifierBuild(
    covariant Orders notifier,
  ) {
    return notifier.build(
      bnbId,
    );
  }

  @override
  Override overrideWith(Orders Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrdersProvider._internal(
        () => create()..bnbId = bnbId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bnbId: bnbId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Orders, List<Order>> createElement() {
    return _OrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersProvider && other.bnbId == bnbId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bnbId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrdersRef on AutoDisposeAsyncNotifierProviderRef<List<Order>> {
  /// The parameter `bnbId` of this provider.
  int get bnbId;
}

class _OrdersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Orders, List<Order>>
    with OrdersRef {
  _OrdersProviderElement(super.provider);

  @override
  int get bnbId => (origin as OrdersProvider).bnbId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
