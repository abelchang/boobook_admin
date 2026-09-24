import 'package:boobook_admin/app/core/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('weekdayLabel', () {
    test('2026-09-24 是星期四', () {
      expect(DateTime(2026, 9, 24).weekdayLabel, '星期四');
    });

    test('2026-09-27 是星期日', () {
      expect(DateTime(2026, 9, 27).weekdayLabel, '星期日');
    });

    test('2026-01-01 是星期四（元旦）', () {
      expect(DateTime(2026, 1, 1).weekdayLabel, '星期四');
    });

    test('null 回傳空字串', () {
      DateTime? nullDate;
      expect(nullDate.weekdayLabel, '');
    });
  });
}