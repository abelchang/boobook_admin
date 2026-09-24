import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'orders_repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<List<Order>> getAllOrders(int bnbId) async {
    final result = await Network.instance.getData("/getAllOrdersByBnb/$bnbId");

    switch (result["success"]) {
      case true:
        return (result['orders'] as List?)
                ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception();
    }
  }
}

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl();
});
