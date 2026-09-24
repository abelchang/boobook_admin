import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:boobook_admin/app/features/orders/providers/orders_providers.dart';
import 'package:boobook_admin/app/features/orders/widget/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersView extends ConsumerWidget {
  const OrdersView({required this.bnb, super.key});
  final Bnb bnb;

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersDataAsync = ref.watch(ordersProvider(bnb.id ?? 0));

    return ordersDataAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (orders) {
        return Scaffold(
            appBar: AppBar(
              title: Text(bnb.bnbName ?? ''),
            ),
            body: OrdersWidget(
              orders: orders,
            ));
      },
    );
  }
}
