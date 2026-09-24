import 'package:boobook_admin/app/core/utils/money_utils.dart';
import 'package:boobook_admin/app/core/widget/money_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatNTMoney（顯示用）', () {
    test('未滿 1 萬維持千分位，1 萬以上由套件縮寫成萬', () {
      expect(formatNTMoney(0), 'NT\$0');
      expect(formatNTMoney(999), 'NT\$999');
      expect(formatNTMoney(5000), 'NT\$5,000');
      expect(formatNTMoney(9999), 'NT\$9,999');
      expect(formatNTMoney(15000), 'NT\$1.5萬');
      expect(formatNTMoney(58000), 'NT\$5.8萬');
      expect(formatNTMoney(1234567), 'NT\$123萬');
    });
  });

  group('formatNTMoneyFull（完整金額）', () {
    test('一律千分位、不縮寫', () {
      expect(formatNTMoneyFull(0), 'NT\$0');
      expect(formatNTMoneyFull(5000), 'NT\$5,000');
      expect(formatNTMoneyFull(58000), 'NT\$58,000');
      expect(formatNTMoneyFull(1234567), 'NT\$1,234,567');
    });
  });

  group('MoneyText', () {
    testWidgets('未滿 1 萬：直接顯示千分位金額、無 tooltip', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MoneyText(5000))),
      );

      expect(find.text('NT\$5,000'), findsOneWidget);
      expect(find.byType(Tooltip), findsNothing);
    });

    testWidgets('1 萬以上：縮寫顯示，點一下 tooltip 彈出完整金額', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MoneyText(58000))),
      );

      // 縮寫。
      expect(find.text('NT\$5.8萬'), findsOneWidget);

      // 點一下 → tooltip 顯示完整千分位金額。
      await tester.tap(find.text('NT\$5.8萬'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('NT\$58,000'), findsOneWidget);
    });
  });
}