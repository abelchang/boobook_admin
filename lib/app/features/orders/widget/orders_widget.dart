import 'package:boobook_admin/app/core/widget/money_text.dart';
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_status.dart';
import 'package:boobook_admin/app/features/orders/view/month_orders_view.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key, required this.orders, this.bnbName});

  final List<Order> orders;
  final String? bnbName;

  @override
  Widget build(BuildContext context) {
    final nowYear = DateTime.now().year;
    final byMonth = <int, ({int count, int sum})>{};
    final byYear = <int, ({int count, int sum})>{};

    for (final order in orders) {
      // 取消/延期/候補不計入營收（訂單數仍含，因為列表照樣顯示）。
      final revenue = orderCountsAsRevenue(order) ? order.price : 0;
      if (order.checkin.year == nowYear) {
        byMonth.update(
          order.checkin.month,
          (v) => (count: v.count + 1, sum: v.sum + revenue),
          ifAbsent: () => (count: 1, sum: revenue),
        );
      } else {
        byYear.update(
          order.checkin.year,
          (v) => (count: v.count + 1, sum: v.sum + revenue),
          ifAbsent: () => (count: 1, sum: revenue),
        );
      }
    }

    final monthStats = byMonth.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    final yearStats = byYear.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        if (orders.isEmpty)
          const _OrdersEmpty()
        else ...[
          _SectionHeader(
            title: '今年',
            trailing: '${monthStats.length} 個月',
            color: Colors.blue,
          ),
          for (final e in monthStats)
            _MonthSummaryCard(
              month: e.key,
              count: e.value.count,
              sum: e.value.sum,
              onTap: () => _openMonth(context, e.key),
            ),
          _SectionHeader(
            title: '歷年',
            trailing: '${yearStats.length} 年',
            color: Colors.blueGrey,
          ),
          for (final e in yearStats)
            _YearSummaryCard(
              year: e.key,
              count: e.value.count,
              sum: e.value.sum,
            ),
        ],
      ],
    );
  }

  void _openMonth(BuildContext context, int month) {
    final bnbId = orders.isEmpty ? 0 : orders.first.bnbId;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => MonthOrdersView(
        bnbId: bnbId,
        bnbName: bnbName,
        year: DateTime.now().year,
        month: month,
        orders: orders,
      ),
    ));
  }
}

/// 區段標題（今年 / 歷年），左側色條＋右側摘要。
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.trailing,
    this.color = Colors.blue,
  });

  final String title;
  final String trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            trailing,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

/// 今年的月份卡：整張可點，進入當月明細頁。
class _MonthSummaryCard extends StatelessWidget {
  const _MonthSummaryCard({
    required this.month,
    required this.count,
    required this.sum,
    required this.onTap,
  });

  final int month;
  final int count;
  final int sum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              _SummaryBadge(
                main: '$month',
                sub: '月',
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$count 筆訂單',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MoneyText(
                    sum,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade300,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '營收',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.blueGrey),
            ],
          ),
        ),
      ),
    );
  }
}

/// 歷年卡：純展示，不可點。
class _YearSummaryCard extends StatelessWidget {
  const _YearSummaryCard({
    required this.year,
    required this.count,
    required this.sum,
  });

  final int year;
  final int count;
  final int sum;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            _SummaryBadge(
              main: '$year',
              sub: '年',
              color: Colors.blueGrey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$count 筆訂單',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            MoneyText(
              sum,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryBadge extends StatelessWidget {
  const _SummaryBadge({
    required this.main,
    required this.sub,
    required this.color,
  });

  final String main;
  final String sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              main,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Text(
            sub,
            style: TextStyle(fontSize: 9, color: color, height: 1.1),
          ),
        ],
      ),
    );
  }
}

class _OrdersEmpty extends StatelessWidget {
  const _OrdersEmpty();

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey.shade400;
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined, size: 64, color: grey),
          const SizedBox(height: 12),
          const Text(
            '尚無訂單資料',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            '有訂單後會在這裡顯示每月營收',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}