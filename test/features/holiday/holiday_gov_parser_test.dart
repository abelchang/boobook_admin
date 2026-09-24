import 'package:boobook_admin/app/features/holiday/providers/holiday_gov_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('govDateToIso', () {
    test('yyyyMMdd 轉為 yyyy-MM-dd', () {
      expect(govDateToIso('20180101'), '2018-01-01');
      expect(govDateToIso('20231231'), '2023-12-31');
    });

    test('已是 ISO 日期則原樣保留', () {
      expect(govDateToIso('2018-01-01'), '2018-01-01');
    });
  });

  group('parseGovHolidayList', () {
    test('正確解析名稱、假日旗標、分類與描述；tep 一律 false', () {
      final raw = [
        {
          'date': '20180101',
          'year': '2018',
          'name': '中華民國開國紀念日',
          'isholiday': '是',
          'holidaycategory': '放假之紀念日及節日',
          'description': '全國各機關學校放假一日',
        },
        {
          'date': '20180215',
          'year': '2018',
          'name': '除夕',
          'isholiday': '否',
          'holidaycategory': null,
          'description': null,
        },
      ];

      final result = parseGovHolidayList(raw);

      expect(result, hasLength(2));
      expect(result[0].date, DateTime(2018, 1, 1));
      expect(result[0].name, '中華民國開國紀念日');
      expect(result[0].isHoliday, isTrue);
      expect(result[0].holidayCategory, '放假之紀念日及節日');
      expect(result[0].description, '全國各機關學校放假一日');
      expect(result[0].tep, isFalse);

      expect(result[1].isHoliday, isFalse);
      expect(result[1].holidayCategory, '');
      expect(result[1].description, '');
    });

    test('跳過沒有名字的星期六、星期日列', () {
      final raw = [
        {
          'date': '20180106',
          'year': '2018',
          'name': null,
          'isholiday': '是',
          'holidaycategory': '星期六、星期日',
          'description': null,
        },
        {
          'date': '20180101',
          'year': '2018',
          'name': '中華民國開國紀念日',
          'isholiday': '是',
          'holidaycategory': '放假之紀念日及節日',
          'description': '全國各機關學校放假一日',
        },
      ];

      final result = parseGovHolidayList(raw);

      expect(result, hasLength(1));
      expect(result.single.name, '中華民國開國紀念日');
    });

    test('null-name 的補班日（非假日）與補假/調整放假日依 category 補名保留', () {
      final raw = [
        {
          'date': '20180331',
          'year': '2018',
          'name': null,
          'isholiday': '否',
          'holidaycategory': '補行上班日',
          'description': null,
        },
        {
          'date': '20180619',
          'year': '2018',
          'name': null,
          'isholiday': '是',
          'holidaycategory': '補假',
          'description': null,
        },
        {
          'date': '20180925',
          'year': '2018',
          'name': null,
          'isholiday': '是',
          'holidaycategory': '調整放假日',
          'description': null,
        },
      ];

      final result = parseGovHolidayList(raw);

      expect(result, hasLength(3));
      expect(result[0].name, '補行上班日');
      expect(result[0].isHoliday, isFalse);
      expect(result[0].holidayCategory, '補行上班日');
      expect(result[1].name, '補假');
      expect(result[1].isHoliday, isTrue);
      expect(result[2].name, '調整放假日');
      expect(result[2].isHoliday, isTrue);
    });

    test('跳過日期格式不符或缺少日期的列', () {
      final raw = [
        {'date': 'not-a-date', 'name': '壞日期', 'isholiday': '是'},
        {'name': '缺日期', 'isholiday': '是'},
      ];

      expect(parseGovHolidayList(raw), isEmpty);
    });
  });
}