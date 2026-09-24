// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_providers.g.dart';

@riverpod
class Orders extends _$Orders {
  @override
  Future<List<Order>> build(int bnbId) async {
    final repository = ref.read(ordersRepositoryProvider);
    final bnbs = await repository.getAllOrders(bnbId);
    return bnbs;
  }
}

/// 房型＋通路段：進月份明細頁才觸發，一次載入供整月卡片對照。
@riverpod
class BnbOrderReferences extends _$BnbOrderReferences {
  @override
  Future<OrderReferences> build(int bnbId) async {
    final repository = ref.read(ordersRepositoryProvider);
    return repository.getOrderReferences(bnbId);
  }
}

/// 單筆客戶：點開訂單明細 sheet 才觸發（1 read）。
@riverpod
class CustomerInfo extends _$CustomerInfo {
  @override
  Future<OrderCustomer?> build(int customerId) async {
    final repository = ref.read(ordersRepositoryProvider);
    return repository.getCustomer(customerId);
  }
}
