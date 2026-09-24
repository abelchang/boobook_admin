import 'package:boobook_admin/app/core/utils/money_utils.dart';
import 'package:flutter/material.dart';

/// 大額金額顯示元件：全 App 金錢顯示的單一入口。
///
/// 顯示縮寫（NT$1 萬以上 → `xx.x萬`）；**點一下**以 tooltip 彈出完整千分位金額
/// （如 `NT$123,456`）。未滿 1 萬時縮寫＝完整，直接顯示、不加 tooltip。
///
/// 各頁要改金額格式時只改這支（含 [formatNTMoney]）即可。
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.value, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  /// 金額（整數，NT 元）。
  final int value;

  /// 沿用所處環境的文字樣式（未指定時用畫面預設）。
  final TextStyle? style;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final display = formatNTMoney(value);
    final full = formatNTMoneyFull(value);
    final text = Text(
      display,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
    // 縮寫與完整相同（未滿 1 萬）時 tooltip 沒有意義，直接顯示即可。
    if (display == full) {
      return text;
    }
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: full,
      child: text,
    );
  }
}