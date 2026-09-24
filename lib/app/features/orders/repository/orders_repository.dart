import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';

abstract class OrdersRepository {
  Future<List<Order>> getAllOrders(int bnbId);

  /// 房型＋通路段（進月份明細頁載入一次）。
  Future<OrderReferences> getOrderReferences(int bnbId);

  /// 單筆客戶（只開明細 sheet 時才載）。查無回傳 null。
  Future<OrderCustomer?> getCustomer(int customerId);
}
