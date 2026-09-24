import 'order.dart';

/// 訂單狀態（對應後端 order_statuses 穩定資料）。
enum OrderStatus {
  reserved(1, '預訂'),
  depositPaid(2, '付訂'),
  paidInFull(3, '付清'),
  cancelled(4, '取消'),
  deferredReserved(5, '延期預訂'),
  deferredDeposit(6, '延期付訂'),
  deferredPaid(7, '延期付清'),
  waitlist(8, '候補');

  const OrderStatus(this.id, this.label);

  final int id;
  final String label;

  /// 由後端數值解析；未知 id 回 null。
  static OrderStatus? fromId(int id) {
    for (final s in values) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// 是否計入營收（取消 / 延期 / 候補除外）。
  bool get countsAsRevenue =>
      !const {
            cancelled,
            deferredReserved,
            deferredDeposit,
            deferredPaid,
            waitlist,
          }.contains(this);
}

/// 該訂單是否計入營收統計。
bool orderCountsAsRevenue(Order order) =>
    OrderStatus.fromId(order.orderStatusId)?.countsAsRevenue ?? false;