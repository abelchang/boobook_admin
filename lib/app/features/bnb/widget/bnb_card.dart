import 'package:boobook_admin/app/core/widget/money_text.dart';
import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:boobook_admin/app/features/orders/view/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 頭像漸層色盤（依 bnb id 固定取色，穩定不閃爍）。
const List<(Color, Color)> _avatarPalette = [
  (Color(0xFF5C6BC0), Color(0xFF303F9F)), // indigo
  (Color(0xFF26A69A), Color(0xFF00695C)), // teal
  (Color(0xFFFFA726), Color(0xFFE65100)), // orange
  (Color(0xFFAB47BC), Color(0xFF6A1B9A)), // purple
  (Color(0xFF42A5F5), Color(0xFF1565C0)), // blue
  (Color(0xFFEF5350), Color(0xFFC62828)), // red
  (Color(0xFF66BB6A), Color(0xFF2E7D32)), // green
  (Color(0xFF8D6E63), Color(0xFF4E342E)), // brown
];

class BnbCard extends StatelessWidget {
  const BnbCard({required this.bnb, super.key});
  final Bnb bnb;

  @override
  Widget build(BuildContext context) {
    final name = bnb.bnbName?.trim().isNotEmpty ?? false
        ? bnb.bnbName!.trim()
        : '未命名民宿';
    // 依 id（或名稱）固定選一組漸層，讓每間民宿有穩定的代表色。
    final (start, end) =
        _avatarPalette[((bnb.id ?? name.hashCode).abs()) %
            _avatarPalette.length];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => OrdersView(bnb: bnb))),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [start, end],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  name.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _InfoChip(
                          icon: Icons.receipt_long_outlined,
                          label: Text(
                            '${bnb.ordersCount} 筆訂單',
                            style: _chipLabelStyle(const Color(0xFF1565C0)),
                          ),
                          color: const Color(0xFF1565C0),
                        ),
                        // 有效營收（預訂/付訂/付清），後端 deploy 前欄位為 null → 不顯示。
                        if (bnb.revenueEffective != null)
                          _InfoChip(
                            icon: Icons.payments_outlined,
                            color: Colors.pink.shade400,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '有效營收 ',
                                  style: _chipLabelStyle(Colors.pink.shade400),
                                ),
                                MoneyText(
                                  bnb.revenueEffective!,
                                  style:
                                      _chipLabelStyle(Colors.pink.shade400),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    if (bnb.createdAt != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '成立於 ${DateFormat('yyyy/MM').format(bnb.createdAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: Colors.blueGrey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle _chipLabelStyle(Color color) =>
    TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600);

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final Widget label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 3),
          label,
        ],
      ),
    );
  }
}
