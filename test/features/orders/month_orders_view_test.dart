import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:boobook_admin/app/features/orders/model/order_relations.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository_impl.dart';
import 'package:boobook_admin/app/features/orders/view/month_orders_view.dart';
import 'package:boobook_admin/app/features/orders/widget/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Order _order(
  int id,
  DateTime checkin,
  DateTime checkout, {
  int price = 1000,
  int status = 3,
  int depositPay = 0,
  String memo = '',
  int roomId = 1,
  int orderPlaceId = 1,
  int customerId = 1,
}) =>
    Order(
      id: id,
      createdAt: checkin,
      updatedAt: checkin,
      checkin: checkin,
      checkout: checkout,
      customerId: customerId,
      roomId: roomId,
      orderStatusId: status,
      orderPlaceId: orderPlaceId,
      bnbId: 1,
      price: price,
      depositPay: depositPay,
      memo: memo,
    );

class _FakeOrdersRepo implements OrdersRepository {
  _FakeOrdersRepo({this.references, this.customer});

  final OrderReferences? references;
  final OrderCustomer? customer;

  @override
  Future<List<Order>> getAllOrders(int bnbId) async => [];

  @override
  Future<OrderReferences> getOrderReferences(int bnbId) async =>
      references ?? const OrderReferences(rooms: [], places: []);

  @override
  Future<OrderCustomer?> getCustomer(int customerId) async => customer;
}

/// 包 ProviderScope：MonthOrdersView 及會導向它的 OrdersWidget 需要 ordersRepositoryProvider。
Widget _app(Widget home, {OrdersRepository? repo}) => ProviderScope(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(repo ?? _FakeOrdersRepo()),
      ],
      child: MaterialApp(home: home),
    );

void main() {
  group('MonthOrdersView', () {
    testWidgets('只顯示目標月份的訂單並依入住日期分組', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(1, DateTime(now.year, now.month, 5), DateTime(now.year, now.month, 8)),
        _order(2, DateTime(now.year, now.month, 1), DateTime(now.year, now.month, 2)),
        _order(3, DateTime(now.year, 1, 10), DateTime(now.year, 1, 12)),
      ];

      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: orders,
          ),
        ),
      );

      // 目標月份的兩筆都在，其他月份的沒有。
      expect(find.text('訂單 #1'), findsOneWidget);
      expect(find.text('訂單 #2'), findsOneWidget);
      expect(find.text('訂單 #3'), findsNothing);

      // 日期分組標頭。
      expect(find.text('${now.month} 月 5 日'), findsOneWidget);
      expect(find.text('${now.month} 月 1 日'), findsOneWidget);

      // 統計卡：2 筆、總晚數 3+1=4。
      expect(find.text('2 筆'), findsOneWidget);
      expect(find.text('4 晚'), findsOneWidget);
      expect(find.text('訂單數'), findsOneWidget);
      expect(find.text('總營收'), findsOneWidget);
    });

    testWidgets('顯示狀態徽章與訂金已收/未收', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(
          1,
          DateTime(now.year, now.month, 5),
          DateTime(now.year, now.month, 8),
          status: 1,
          depositPay: 500,
        ),
        _order(
          2,
          DateTime(now.year, now.month, 10),
          DateTime(now.year, now.month, 12),
          status: 4,
        ),
      ];

      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: orders,
          ),
        ),
      );

      expect(find.text('預訂'), findsOneWidget);
      expect(find.text('取消'), findsOneWidget);
      expect(find.text('訂金已收 '), findsOneWidget);
      // 統計卡「訂金已收」＋訂金 chip 各一處。
      expect(find.text('NT\$500'), findsNWidgets(2));
      expect(find.text('訂金未收'), findsOneWidget);
    });

    testWidgets('取消/延期/候補訂單不計入營收（訂單數仍計入）', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(
          1,
          DateTime(now.year, now.month, 5),
          DateTime(now.year, now.month, 8),
          price: 2000,
          status: 3,
          depositPay: 1000,
        ),
        _order(
          2,
          DateTime(now.year, now.month, 6),
          DateTime(now.year, now.month, 9),
          price: 3000,
          status: 4,
        ),
        _order(
          3,
          DateTime(now.year, now.month, 7),
          DateTime(now.year, now.month, 10),
          price: 4000,
          status: 8,
        ),
      ];

      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: orders,
          ),
        ),
      );

      // 總營收只含有效的第 1 筆：統計卡 + 9/5 當日標頭 + 第 1 筆房費。
      expect(find.text('NT\$2,000'), findsNWidgets(3));
      // 取消(9/6)與候補(9/7)的當日營收為 0。
      expect(find.text('NT\$0'), findsNWidgets(2));
      // 訂單數仍計入全部 3 筆，明細卡照樣顯示各自房費。
      expect(find.text('3 筆'), findsOneWidget);
      expect(find.textContaining('NT\$3,000'), findsOneWidget);
      expect(find.textContaining('NT\$4,000'), findsOneWidget);
    });

    testWidgets('點訂單卡片打開明細 bottom sheet', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(1, DateTime(now.year, now.month, 5), DateTime(now.year, now.month, 8)),
      ];

      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: orders,
          ),
        ),
      );

      await tester.tap(find.text('訂單 #1'));
      await tester.pumpAndSettle();

      // 明細以名稱取代 id（參考資料未載入時退回 #id），客戶查無退回 #id。
      expect(find.text('房型'), findsOneWidget);
      expect(find.text('房型 #1'), findsNWidgets(2)); // 卡片＋明細
      expect(find.text('訂單來源'), findsOneWidget);
      expect(find.text('客戶'), findsOneWidget);
      expect(find.text('#1'), findsOneWidget); // 客戶退回 id
    });

    testWidgets('進月份頁載入房型/來源名稱，客戶資訊點入明細才載入', (tester) async {
      final now = DateTime.now();
      final repo = _FakeOrdersRepo(
        references: const OrderReferences(
          rooms: [OrderRoom(id: 3, roomName: '山景雙人房')],
          places: [OrderPlace(id: 2, orderPlace: 'Booking.com')],
        ),
        customer: const OrderCustomer(
          id: 9,
          customerName: '王小明',
          phone: '0912345678',
        ),
      );
      final order = _order(
        1,
        DateTime(now.year, now.month, 5),
        DateTime(now.year, now.month, 8),
        roomId: 3,
        orderPlaceId: 2,
      );

      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: [order],
          ),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle(); // 讓房型／通路段 provider 完成。

      // 卡片上直接看到房型與來源名稱。
      expect(find.text('山景雙人房'), findsOneWidget);
      expect(find.text('Booking.com'), findsOneWidget);
      // 客戶資訊不會出現在卡片上（也尚未讀取）。
      expect(find.textContaining('王小明'), findsNothing);

      // 點入明細後才載入客戶姓名＋電話。
      await tester.tap(find.text('訂單 #1'));
      await tester.pumpAndSettle();
      expect(find.text('王小明 · 0912345678'), findsOneWidget);
      expect(find.text('客戶'), findsOneWidget);
    });

    testWidgets('該月無訂單顯示空狀態', (tester) async {
      final now = DateTime.now();
      await tester.pumpWidget(
        _app(
          MonthOrdersView(
            bnbId: 1,
            bnbName: '測試民宿',
            year: now.year,
            month: now.month,
            orders: [
              _order(3, DateTime(now.year, 1, 10), DateTime(now.year, 1, 12)),
            ],
          ),
        ),
      );

      expect(find.text('本月尚無訂單'), findsOneWidget);
    });
  });

  group('OrdersWidget', () {
    testWidgets('今年的月份卡整張可點且顯示訂單數', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(1, DateTime(now.year, now.month, 5), DateTime(now.year, now.month, 8)),
        _order(2, DateTime(now.year, now.month, 10), DateTime(now.year, now.month, 12)),
      ];

      await tester.pumpWidget(
        _app(
          Scaffold(
            body: OrdersWidget(orders: orders, bnbName: '測試民宿'),
          ),
        ),
      );

      // 訂單數與營收（2 筆 x NT$1,000）。
      expect(find.text('2 筆訂單'), findsOneWidget);
      expect(find.text('NT\$2,000'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      await tester.tap(find.text('2 筆訂單'));
      await tester.pumpAndSettle();

      expect(find.text('${now.year} 年 ${now.month} 月'), findsOneWidget);
      expect(find.text('訂單 #1'), findsOneWidget);
    });

    testWidgets('歷年月份不可點擊且無 chevron', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(1, DateTime(now.year - 1, 5, 5), DateTime(now.year - 1, 5, 8)),
      ];

      await tester.pumpWidget(
        _app(
          Scaffold(body: OrdersWidget(orders: orders, bnbName: '測試民宿')),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsNothing);
      expect(find.text('${now.year - 1}'), findsOneWidget);
      expect(find.text('1 筆訂單'), findsOneWidget);
    });

    testWidgets('沒有訂單時顯示空狀態', (tester) async {
      await tester.pumpWidget(
        _app(
          Scaffold(body: OrdersWidget(orders: const [], bnbName: '測試民宿')),
        ),
      );

      expect(find.text('尚無訂單資料'), findsOneWidget);
    });

    testWidgets('營收排除取消訂單（訂單數仍計入）', (tester) async {
      final now = DateTime.now();
      final orders = [
        _order(
          1,
          DateTime(now.year, now.month, 5),
          DateTime(now.year, now.month, 8),
          price: 2000,
          status: 3,
        ),
        _order(
          2,
          DateTime(now.year, now.month, 6),
          DateTime(now.year, now.month, 9),
          price: 3000,
          status: 4,
        ),
      ];

      await tester.pumpWidget(
        _app(
          Scaffold(body: OrdersWidget(orders: orders, bnbName: '測試民宿')),
        ),
      );

      // 2 筆都算訂單數，但營收只加有效的 2,000。
      expect(find.text('2 筆訂單'), findsOneWidget);
      expect(find.text('NT\$2,000'), findsOneWidget);
      expect(find.text('NT\$3,000'), findsNothing);
    });
  });
}