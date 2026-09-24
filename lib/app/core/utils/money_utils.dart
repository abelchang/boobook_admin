import 'package:intl/intl.dart';

/// 完整金額（千分位）：`999 → NT$999`、`5000 → NT$5,000`、`1234567 → NT$1,234,567`。
final NumberFormat _ntFullFmt = NumberFormat.currency(
  symbol: 'NT\$',
  decimalDigits: 0,
);

/// 大額縮寫（intl compactCurrency zh_TW）：NT$1 萬以上自動以「萬／億／兆」呈現。
final NumberFormat _ntCompactFmt = NumberFormat.compactCurrency(
  locale: 'zh_TW',
  symbol: 'NT\$',
  decimalDigits: 0,
);

/// 顯示用金額：NT$1 萬（10^4）以上由 intl compact 縮寫（`58000 → NT$5.8萬`）；
/// 未滿 1 萬用千分位（`5000 → NT$5,000`）。
///
/// 這分支是刻意的：intl 的 compact 模式在 `compact_number_format.dart` 建構子直接
/// `turnOffGrouping()`，未壓縮路徑（< 1 萬）也不插千分位、且沒有開啟的 API——千分位
/// 只能靠一般 currency 格式（[NumberFormat.currency]）補上。
String formatNTMoney(int value) =>
    value >= 10000 ? _ntCompactFmt.format(value) : _ntFullFmt.format(value);

/// 完整金額（千分位），供 tooltip、明細頁等需要確切數字的場合。
String formatNTMoneyFull(int value) => _ntFullFmt.format(value);