import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'orders_repository.dart';

/// 有上限的先進先出快取：超過上限時淘汰最早放入的 key。
/// 給「不常變動的資料」用（房型／通路／客戶）——取得一次就一路有效，不放 TTL；
/// 用 FIFO 數量上限防止設備端記憶體無限成長。
class _BoundedFifoCache<K, V> {
  _BoundedFifoCache({required this.maxEntries});

  final int maxEntries;

  /// LinkedHashMap 保留插入順序，可用來做 FIFO 淘汰。
  final Map<K, V> _entries = <K, V>{};

  V? lookup(K key) => _entries[key];

  void store(K key, V value) {
    if (!_entries.containsKey(key) && _entries.length >= maxEntries) {
      _entries.remove(_entries.keys.first); // 淘汰最早進來的
    }
    _entries[key] = value;
  }
}

/// 訂單 repository 的 singleton 實作。
/// 前端快取放這層（所有呼叫的單一 choke point），跨畫面、跨 provider 生命週期有效：
/// Riverpod 3 的 provider 預設 autoDispose，畫面關閉即 dispose、重開會重建並重打後端；
/// 有了這層記憶體快取，房型／通路／客戶在 App 生命週期內只會向後端要一次。
class OrdersRepositoryImpl extends OrdersRepository {
  OrdersRepositoryImpl._();

  static final OrdersRepositoryImpl instance = OrdersRepositoryImpl._();

  /// 快取數量上限（先進先出），房型/通路/客戶各一張表。
  static const int _cacheLimit = 1000;

  /// 房型＋通路段：以 bnbId 為 key（月份頁一次載入整組）。
  final _BoundedFifoCache<int, OrderReferences> _referencesCache =
      _BoundedFifoCache(maxEntries: _cacheLimit);

  /// 客戶：以 customerId 為 key（開明細 sheet 才讀）。
  final _BoundedFifoCache<int, OrderCustomer> _customerCache =
      _BoundedFifoCache(maxEntries: _cacheLimit);

  @override
  Future<List<Order>> getAllOrders(int bnbId) async {
    // 訂單內容會變動（新預訂／狀態變更），不做前端快取，每次都向後端拿最新。
    final result = await Network.instance.getData('/getAllOrdersByBnb/$bnbId');

    switch (result['success']) {
      case true:
        return (result['orders'] as List?)
                ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception();
    }
  }

  @override
  Future<OrderReferences> getOrderReferences(int bnbId) async {
    final cached = _referencesCache.lookup(bnbId);
    if (cached != null) return cached;

    final result = await Network.instance.getData('/getOrderReferences/$bnbId');

    switch (result['success']) {
      case true:
        final references = OrderReferences(
          rooms: (result['rooms'] as List?)
                  ?.map((e) => OrderRoom.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
          places: (result['orderPlaces'] as List?)
                  ?.map((e) => OrderPlace.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        );
        _referencesCache.store(bnbId, references);
        return references;
      default:
        throw Exception();
    }
  }

  @override
  Future<OrderCustomer?> getCustomer(int customerId) async {
    final cached = _customerCache.lookup(customerId);
    if (cached != null) return cached;

    final result = await Network.instance.getData('/getCustomer/$customerId');

    switch (result['success']) {
      case true:
        final customer = result['customer'];
        // 查無（null）；不回存，避免與「未快取」混淆（極少見的邊緣案例）。
        if (customer == null) return null;
        final parsed =
            OrderCustomer.fromJson(customer as Map<String, dynamic>);
        _customerCache.store(customerId, parsed);
        return parsed;
      default:
        throw Exception();
    }
  }
}

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl.instance;
});