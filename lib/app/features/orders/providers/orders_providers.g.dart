// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Orders)
final ordersProvider = OrdersFamily._();

final class OrdersProvider extends $AsyncNotifierProvider<Orders, List<Order>> {
  OrdersProvider._({
    required OrdersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'ordersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ordersHash();

  @override
  String toString() {
    return r'ordersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Orders create() => Orders();

  @override
  bool operator ==(Object other) {
    return other is OrdersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ordersHash() => r'4ec06b4382fefe6c6142474c5273e5554b1e8e30';

final class OrdersFamily extends $Family
    with
        $ClassFamilyOverride<
          Orders,
          AsyncValue<List<Order>>,
          List<Order>,
          FutureOr<List<Order>>,
          int
        > {
  OrdersFamily._()
    : super(
        retry: null,
        name: r'ordersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrdersProvider call(int bnbId) =>
      OrdersProvider._(argument: bnbId, from: this);

  @override
  String toString() => r'ordersProvider';
}

abstract class _$Orders extends $AsyncNotifier<List<Order>> {
  late final _$args = ref.$arg as int;
  int get bnbId => _$args;

  FutureOr<List<Order>> build(int bnbId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Order>>, List<Order>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Order>>, List<Order>>,
              AsyncValue<List<Order>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。

@ProviderFor(BnbOrderReferences)
final bnbOrderReferencesProvider = BnbOrderReferencesFamily._();

/// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。
final class BnbOrderReferencesProvider
    extends $AsyncNotifierProvider<BnbOrderReferences, OrderReferences> {
  /// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。
  BnbOrderReferencesProvider._({
    required BnbOrderReferencesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'bnbOrderReferencesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bnbOrderReferencesHash();

  @override
  String toString() {
    return r'bnbOrderReferencesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BnbOrderReferences create() => BnbOrderReferences();

  @override
  bool operator ==(Object other) {
    return other is BnbOrderReferencesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bnbOrderReferencesHash() =>
    r'84d118a822ef214fd38a6f042aa517313cef492c';

/// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。

final class BnbOrderReferencesFamily extends $Family
    with
        $ClassFamilyOverride<
          BnbOrderReferences,
          AsyncValue<OrderReferences>,
          OrderReferences,
          FutureOr<OrderReferences>,
          int
        > {
  BnbOrderReferencesFamily._()
    : super(
        retry: null,
        name: r'bnbOrderReferencesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。

  BnbOrderReferencesProvider call(int bnbId) =>
      BnbOrderReferencesProvider._(argument: bnbId, from: this);

  @override
  String toString() => r'bnbOrderReferencesProvider';
}

/// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。

abstract class _$BnbOrderReferences extends $AsyncNotifier<OrderReferences> {
  late final _$args = ref.$arg as int;
  int get bnbId => _$args;

  FutureOr<OrderReferences> build(int bnbId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OrderReferences>, OrderReferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderReferences>, OrderReferences>,
              AsyncValue<OrderReferences>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。

@ProviderFor(CustomerInfo)
final customerInfoProvider = CustomerInfoFamily._();

/// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。
final class CustomerInfoProvider
    extends $AsyncNotifierProvider<CustomerInfo, OrderCustomer?> {
  /// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。
  CustomerInfoProvider._({
    required CustomerInfoFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'customerInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerInfoHash();

  @override
  String toString() {
    return r'customerInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CustomerInfo create() => CustomerInfo();

  @override
  bool operator ==(Object other) {
    return other is CustomerInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerInfoHash() => r'b90cc8ca3d014f96ef3c0140556598e05cd1fae4';

/// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。

final class CustomerInfoFamily extends $Family
    with
        $ClassFamilyOverride<
          CustomerInfo,
          AsyncValue<OrderCustomer?>,
          OrderCustomer?,
          FutureOr<OrderCustomer?>,
          int
        > {
  CustomerInfoFamily._()
    : super(
        retry: null,
        name: r'customerInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。

  CustomerInfoProvider call(int customerId) =>
      CustomerInfoProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerInfoProvider';
}

/// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。

abstract class _$CustomerInfo extends $AsyncNotifier<OrderCustomer?> {
  late final _$args = ref.$arg as int;
  int get customerId => _$args;

  FutureOr<OrderCustomer?> build(int customerId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OrderCustomer?>, OrderCustomer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderCustomer?>, OrderCustomer?>,
              AsyncValue<OrderCustomer?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
