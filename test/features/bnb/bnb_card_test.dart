import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:boobook_admin/app/features/bnb/widget/bnb_list.dart';
import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeOrdersRepo implements OrdersRepository {
  @override
  Future<List<Order>> getAllOrders(int bnbId) async => [];

  @override
  Future<OrderReferences> getOrderReferences(int bnbId) async =>
      const OrderReferences(rooms: [], places: []);

  @override
  Future<OrderCustomer?> getCustomer(int customerId) async => null;
}

void main() {
  testWidgets('顯示民宿名稱、訂單數、有效營收與成立日期', (tester) async {
    final bnb = Bnb(
      id: 1,
      bnbName: '日光小屋',
      createdAt: DateTime(2021, 3, 10),
      revenueEffective: 58000,
      ordersCount: 12,
    );

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: BnbList(bnbs: [bnb]))),
    );

    expect(find.text('日光小屋'), findsOneWidget);
    expect(find.text('12 筆訂單'), findsOneWidget);
    expect(find.text('有效營收 '), findsOneWidget);
    expect(find.text('NT\$5.8萬'), findsOneWidget);
    expect(find.textContaining('成立於 2021/03'), findsOneWidget);
    expect(find.text('1 間'), findsOneWidget);
  });

  testWidgets('有效營收格式化：1 萬以上縮寫成萬、以下維持千分位', (tester) async {
    final bnbs = [
      Bnb(id: 1, bnbName: '小屋甲', revenueEffective: 999, ordersCount: 0),
      Bnb(id: 2, bnbName: '小屋乙', revenueEffective: 5000, ordersCount: 0),
      Bnb(id: 3, bnbName: '小屋丙', revenueEffective: 15000, ordersCount: 0),
    ];

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: BnbList(bnbs: bnbs))),
    );

    expect(find.text('有效營收 '), findsNWidgets(3));
    // 未滿 1 萬：千分位（且縮寫＝完整，無 tooltip 包裹）。
    expect(find.text('NT\$999'), findsNWidgets(1));
    expect(find.text('NT\$5,000'), findsNWidgets(1));
    // 1 萬以上：縮寫成萬。
    expect(find.text('NT\$1.5萬'), findsNWidgets(1));
  });

  testWidgets('後端尚未提供有效營收時不顯示該 chip', (tester) async {
    final bnb = Bnb(id: 1, bnbName: '日光小屋', ordersCount: 2);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: BnbList(bnbs: [bnb]))),
    );

    expect(find.text('2 筆訂單'), findsOneWidget);
    expect(find.textContaining('有效營收'), findsNothing);
  });

  testWidgets('點卡片進入該民宿的訂單頁', (tester) async {
    final bnb = Bnb(id: 1, bnbName: '日光小屋', ordersCount: 3);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(_FakeOrdersRepo()),
        ],
        child: MaterialApp(
          home: Scaffold(body: BnbList(bnbs: [bnb])),
        ),
      ),
    );

    await tester.tap(find.text('日光小屋'));
    await tester.pumpAndSettle();

    // OrdersView 的 AppBar 標題。
    expect(find.text('日光小屋'), findsOneWidget);
  });

  testWidgets('沒有民宿時顯示空狀態', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: BnbList(bnbs: const []))),
    );

    expect(find.text('尚無民宿'), findsOneWidget);
  });
}