import 'package:boobook_admin/app/features/orders/model/order.dart';

abstract class OrdersRepository {
  Future<List<Order>> getAllOrders(int bnbId);
}
