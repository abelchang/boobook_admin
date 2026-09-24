import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:boobook_admin/app/features/bnb/providers/bnb_providers.dart';
import 'package:boobook_admin/app/features/bnb/widget/bnb_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BnbList extends ConsumerWidget {
  const BnbList({super.key, required this.bnbs});
  final List<Bnb> bnbs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                scrolledUnderElevation: 0,
                pinned: true,

                title: Row(
                  children: [
                    const Text('所有民宿'),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${bnbs.length} 間',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    tooltip: '重新整理',
                    onPressed: () => _refresh(ref),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              if (bnbs.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyBnbs(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverList.list(
                    children: [
                      for (final bnb in bnbs)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BnbCard(bnb: bnb),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(bnbsProvider);
    await ref.read(bnbsProvider.future);
  }
}

class _EmptyBnbs extends StatelessWidget {
  const _EmptyBnbs();

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey.shade400;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.storefront_outlined, size: 72, color: grey),
          const SizedBox(height: 16),
          const Text(
            '尚無民宿',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '建立或匯入後會顯示在這裡',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
