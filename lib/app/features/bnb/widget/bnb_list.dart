import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
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
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              scrolledUnderElevation: 0,
              title: Text('所有民宿'),
              floating: true,
              snap: true,
              actions: [],
            ),
            if (bnbs.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text('沒有資料...'),
                ),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: BnbCard(
                      bnb: bnbs[index],
                    ),
                  );
                },
                childCount: bnbs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
