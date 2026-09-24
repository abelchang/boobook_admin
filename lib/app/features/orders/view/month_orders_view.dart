import 'package:boobook_admin/app/core/utils/money_utils.dart';
import 'package:boobook_admin/app/core/widget/money_text.dart';
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';
import 'package:boobook_admin/app/features/orders/model/order_status.dart';
import 'package:boobook_admin/app/features/orders/providers/orders_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// 訂單狀態 → 徽章顏色（UI 呈現；label 由 [OrderStatus] 提供）。
final Map<OrderStatus, Color> _orderStatusColors = {
  OrderStatus.reserved: const Color(0xFF1565C0),
  OrderStatus.depositPaid: const Color(0xFFE65100),
  OrderStatus.paidInFull: const Color(0xFF2E7D32),
  OrderStatus.cancelled: const Color(0xFF9E9E9E),
  OrderStatus.deferredReserved: const Color(0xFF6A1B9A),
  OrderStatus.deferredDeposit: const Color(0xFF6A1B9A),
  OrderStatus.deferredPaid: const Color(0xFF6A1B9A),
  OrderStatus.waitlist: const Color(0xFF00695C),
};

Color _statusColor(OrderStatus? status) => status == null
    ? Colors.blueGrey
    : (_orderStatusColors[status] ?? Colors.blueGrey);

String _statusLabel(OrderStatus? status, int rawId) =>
    status?.label ?? '狀態 $rawId';

const List<String> _zhWeek = ['一', '二', '三', '四', '五', '六', '日'];

String _weekday(DateTime d) => '星期${_zhWeek[d.weekday - 1]}';

String _shortDate(DateTime d) => '${d.month}/${d.day}';

String _dateTime(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);

/// 統計卡數值共用樣式（文字與金額一致）。
const TextStyle _statValueStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

/// 房型顯示：優先名稱；參考資料未載入或查無時退回 `房型 #id`。
String _roomLabel(Order order, Map<int, String> roomNames) {
  final name = roomNames[order.roomId]?.trim();
  return (name == null || name.isEmpty) ? '房型 #${order.roomId}' : name;
}

/// 訂單來源顯示：優先通路名稱；參考資料未載入或查無時退回 `來源 #id`。
String _placeLabel(Order order, Map<int, String> placeNames) {
  final name = placeNames[order.orderPlaceId]?.trim();
  return (name == null || name.isEmpty) ? '來源 #${order.orderPlaceId}' : name;
}

/// 客戶顯示：姓名（＋電話）；查無時退回 `#id`。
String _customerLabel(Order order, OrderCustomer? customer) {
  if (customer == null || customer.customerName.trim().isEmpty) {
    return '#${order.customerId}';
  }
  final phone = customer.phone.trim();
  return phone.isEmpty
      ? customer.customerName.trim()
      : '${customer.customerName.trim()} · $phone';
}

/// 單一月份（僅今年）的訂單明細頁。
class MonthOrdersView extends ConsumerWidget {
  const MonthOrdersView({
    super.key,
    required this.bnbId,
    required this.bnbName,
    required this.year,
    required this.month,
    required this.orders,
  });

  final int bnbId;
  final String? bnbName;
  final int year;
  final int month;
  final List<Order> orders;

  List<Order> get _monthOrders {
    final list =
        orders
            .where((o) => o.checkin.year == year && o.checkin.month == month)
            .toList()
          ..sort((a, b) {
            final byDate = a.checkin.compareTo(b.checkin);
            return byDate != 0 ? byDate : a.id.compareTo(b.id);
          });
    return list;
  }

  int _nights(Order o) {
    final n = o.checkout.difference(o.checkin).inDays;
    return n < 0 ? 0 : n;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthOrders = _monthOrders;
    // 房型／通路段：進此頁才載入一次。載入完成前卡片先顯示 #id，完成後自動換成名稱。
    final refs = ref.watch(bnbOrderReferencesProvider(bnbId)).value;
    final roomNames = <int, String>{
      for (final r in refs?.rooms ?? const <OrderRoom>[]) r.id: r.roomName.trim(),
    };
    final placeNames = <int, String>{
      for (final p in refs?.places ?? const <OrderPlace>[])
        p.id: p.orderPlace.trim(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$year 年 $month 月'),
            if (bnbName != null && bnbName!.isNotEmpty)
              Text(
                bnbName!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
      ),
      body: monthOrders.isEmpty
          ? const _EmptyOrders()
          : ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _SummaryCard(orders: monthOrders, nightsOf: _nights),
                ..._buildSections(
                  context,
                  monthOrders,
                  roomNames,
                  placeNames,
                ),
              ],
            ),
    );
  }

  List<Widget> _buildSections(
    BuildContext context,
    List<Order> monthOrders,
    Map<int, String> roomNames,
    Map<int, String> placeNames,
  ) {
    final Map<DateTime, List<Order>> byDate = {};
    for (final o in monthOrders) {
      final day = DateTime(o.checkin.year, o.checkin.month, o.checkin.day);
      byDate.putIfAbsent(day, () => []).add(o);
    }

    return [
      for (final entry in byDate.entries) ...[
        _DateHeader(
          day: entry.key,
          count: entry.value.length,
          revenue: entry.value
              .where(orderCountsAsRevenue)
              .fold<int>(0, (sum, o) => sum + (o.price < 0 ? 0 : o.price)),
        ),
        for (final o in entry.value)
          _OrderCard(
            order: o,
            nights: _nights(o),
            roomNames: roomNames,
            placeNames: placeNames,
          ),
      ],
    ];
  }
}

/// 月份統計卡（訂單數 / 總營收 / 訂金已收 / 總晚數）。
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.orders, required this.nightsOf});

  final List<Order> orders;
  final int Function(Order) nightsOf;

  @override
  Widget build(BuildContext context) {
    final count = orders.length;
    final revenue = orders
        .where(orderCountsAsRevenue)
        .fold<int>(0, (sum, o) => sum + (o.price < 0 ? 0 : o.price));
    final deposit = orders.fold<int>(
      0,
      (sum, o) => sum + (o.depositPay < 0 ? 0 : o.depositPay),
    );
    final nights = orders.fold<int>(0, (sum, o) => sum + nightsOf(o));

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          _StatTile(
            icon: Icons.receipt_long_outlined,
            color: const Color(0xFF1565C0),
            value: Text(
              '$count 筆',
              style: _statValueStyle,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            label: '訂單數',
          ),
          const SizedBox(width: 8),
          _StatTile(
            icon: Icons.payments_outlined,
            color: const Color(0xFFE65100),
            value: MoneyText(
              revenue,
              style: _statValueStyle,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            label: '總營收',
          ),
          const SizedBox(width: 8),
          _StatTile(
            icon: Icons.savings_outlined,
            color: const Color(0xFF2E7D32),
            value: MoneyText(
              deposit,
              style: _statValueStyle,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            label: '訂金已收',
          ),
          const SizedBox(width: 8),
          _StatTile(
            icon: Icons.nights_stay_outlined,
            color: const Color(0xFF6A1B9A),
            value: Text(
              '$nights 晚',
              style: _statValueStyle,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            label: '總晚數',
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final Widget value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          value,
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({
    required this.day,
    required this.count,
    required this.revenue,
  });

  final DateTime day;
  final int count;
  final int revenue;

  @override
  Widget build(BuildContext context) {
    final isWeekend = day.weekday >= DateTime.saturday;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
      child: Row(
        children: [
          Text(
            '${day.month} 月 ${day.day} 日',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Text(
            _weekday(day),
            style: TextStyle(
              fontSize: 13,
              color: isWeekend ? Colors.deepOrange.shade400 : Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            '$count 筆',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          MoneyText(
            revenue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 單筆訂單卡片：狀態徽章、日期區間、房型/來源、房費與訂金、memo。
class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.nights,
    required this.roomNames,
    required this.placeNames,
  });

  final Order order;
  final int nights;
  final Map<int, String> roomNames;
  final Map<int, String> placeNames;

  @override
  Widget build(BuildContext context) {
    final status = OrderStatus.fromId(order.orderStatusId);
    final statusColor = _statusColor(status);
    final statusLabel = _statusLabel(status, order.orderStatusId);
    final cancelled = status == OrderStatus.cancelled;
    final depositPay = order.depositPay < 0 ? 0 : order.depositPay;
    final roomLabel = _roomLabel(order, roomNames);
    final placeLabel = _placeLabel(order, placeNames);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () =>
            _showOrderDetail(context, order, roomNames, placeNames),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Opacity(
            opacity: cancelled ? 0.55 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _StatusChip(label: statusLabel, color: statusColor),
                    const Spacer(),
                    Text(
                      '訂單 #${order.id}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      '${_shortDate(order.checkin)} (${_zhWeek[order.checkin.weekday - 1]}) '
                      '→ ${_shortDate(order.checkout)} (${_zhWeek[order.checkout.weekday - 1]})',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$nights 晚',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 房型／訂單來源（優先顯示名稱，後端未附帶時退回 #id）。
                Row(
                  children: [
                    Icon(
                      Icons.meeting_room_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        roomLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.storefront_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        placeLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('房費 ', style: TextStyle(fontSize: 14)),
                        MoneyText(
                          order.price < 0 ? 0 : order.price,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    _DepositChip(paid: depositPay > 0, amount: depositPay),
                  ],
                ),
                if (order.memo.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.08),
                      border: Border(
                        left: BorderSide(
                          color: Colors.amber.shade600,
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order.memo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOrderDetail(
    BuildContext context,
    Order order,
    Map<int, String> roomNames,
    Map<int, String> placeNames,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => _OrderDetailSheet(
        order: order,
        roomNames: roomNames,
        placeNames: placeNames,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DepositChip extends StatelessWidget {
  const _DepositChip({required this.paid, required this.amount});

  final bool paid;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final color = paid ? const Color(0xFF2E7D32) : Colors.grey;
    final depositTextStyle = TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: paid
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('訂金已收 ', style: depositTextStyle),
                MoneyText(amount, style: depositTextStyle),
              ],
            )
          : Text('訂金未收', style: depositTextStyle),
    );
  }
}

/// 點卡片後的完整訂單明細（bottom sheet）。客戶資料在 sheet 開啟時才 lazy 載入。
class _OrderDetailSheet extends ConsumerWidget {
  const _OrderDetailSheet({
    required this.order,
    required this.roomNames,
    required this.placeNames,
  });

  final Order order;
  final Map<int, String> roomNames;
  final Map<int, String> placeNames;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatus.fromId(order.orderStatusId);
    final statusColor = _statusColor(status);
    final statusLabel = _statusLabel(status, order.orderStatusId);
    final nights = order.checkout.difference(order.checkin).inDays < 0
        ? 0
        : order.checkout.difference(order.checkin).inDays;

    // 客戶：開啟 sheet 才讀取（1 read）；載入中顯示 ⋯，失敗或查無退回 #id。
    final customerAsync = ref.watch(customerInfoProvider(order.customerId));
    final customerLabel = switch (customerAsync) {
      AsyncData(:final value) => _customerLabel(order, value),
      AsyncError() => '#${order.customerId}',
      _ => '⋯',
    };

    final rows = <(String, String)>[
      (
        '入住',
        '${order.checkin.year}/${order.checkin.month}/${order.checkin.day} '
            '(${_weekday(order.checkin)})',
      ),
      (
        '退房',
        '${order.checkout.year}/${order.checkout.month}/${order.checkout.day} '
            '(${_weekday(order.checkout)}) · $nights 晚',
      ),
      ('房費', formatNTMoneyFull(order.price < 0 ? 0 : order.price)),
      (
        '訂金已收',
        formatNTMoneyFull(order.depositPay < 0 ? 0 : order.depositPay),
      ),
      ('房型', _roomLabel(order, roomNames)),
      ('訂單來源', _placeLabel(order, placeNames)),
      ('客戶', customerLabel),
      ('建立時間', _dateTime(order.createdAt)),
      ('更新時間', _dateTime(order.updatedAt)),
      ('備註', order.memo.trim().isEmpty ? '—' : order.memo.trim()),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusChip(label: statusLabel, color: statusColor),
                const SizedBox(width: 10),
                Text(
                  '訂單 #${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: '複製訂單編號',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: '${order.id}'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('已複製訂單編號'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_outlined, size: 20),
                ),
              ],
            ),
            const Divider(height: 24),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final (label, value) in rows)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 76,
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SelectableText(
                              value,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey.shade400;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_month_outlined, size: 72, color: grey),
          const SizedBox(height: 16),
          const Text(
            '本月尚無訂單',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '切換其他月份查看營收與訂單內容',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
