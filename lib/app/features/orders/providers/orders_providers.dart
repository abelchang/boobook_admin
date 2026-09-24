// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:boobook_admin/app/features/orders/model/order.dart';
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
