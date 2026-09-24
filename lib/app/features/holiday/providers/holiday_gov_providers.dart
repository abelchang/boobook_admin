import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/holiday.dart';

part 'holiday_gov_providers.g.dart';

/// 新北市開放資料「國定假日」dataset（資料來源：政府公開資訊）。
const _govHolidaysUrl =
    'https://data.ntpc.gov.tw/api/datasets/308DCD75-6434-45BC-A95F-584DA4FED251/json?page=0&size=1000009';

/// 政府資料的日期格式是 `yyyyMMdd`（如 20180101），轉為 ISO 日期 `yyyy-MM-dd`。
String govDateToIso(String raw) {
  final s = raw.trim();
  if (s.length == 8 && !s.contains('-')) {
    return '${s.substring(0, 4)}-${s.substring(4, 6)}-${s.substring(6, 8)}';
  }
  return s;
}

/// 解析政府 API 回傳的原始 JSON 陣列 → [Holiday] 列表。
/// 規則與後端 `govHolidays.ts` 的 `parseGovHolidayRows` 一致：
/// - 具名行（紀念日/節日）直接保留；
/// - null-name 行依 category 補名保留：`補行上班日`（非假日，名稱「補行上班日」）、
///   `補假`/`調整放假日`（國定加放假日，名稱用 category）；
/// - 一般週末（`星期六、星期日`）略過（消費端依 weekday 上色）；
/// - `isholiday` 的「是/否」轉成 bool；
/// - `holidayCategory` / `description` 缺省帶入空字串；
/// - `tep` 一律 false：政府資料沒有「時間電價假日」概念，由 admin 手動標。
List<Holiday> parseGovHolidayList(List<dynamic> raw) {
  final holidays = <Holiday>[];
  for (final item in raw) {
    final map = item as Map<dynamic, dynamic>;
    final rawDate = map['date'] as String?;
    if (rawDate == null) continue;

    final DateTime date;
    try {
      date = DateTime.parse(govDateToIso(rawDate));
    } catch (_) {
      continue; // 格式不符的列直接跳過
    }

    final name = (map['name'] as String?)?.trim() ?? '';
    final category = map['holidaycategory'] as String? ?? '';
    final isHoliday = map['isholiday'] == '是';

    // 具名行沿用；null-name 行依 category 補名
    var finalName = name;
    if (finalName.isEmpty) {
      if (category == '補行上班日') {
        finalName = '補行上班日';
      } else if (isHoliday && (category == '補假' || category == '調整放假日')) {
        finalName = category;
      } else {
        continue;
      }
    }

    holidays.add(Holiday(
      date: date,
      name: finalName,
      isHoliday: isHoliday,
      holidayCategory: category,
      description: map['description'] as String? ?? '',
    ));
  }
  return holidays;
}

@riverpod
class GovHolidays extends _$GovHolidays {
  @override
  Future<List<Holiday>> build() async {
    final response = await Dio().get<List<dynamic>>(
      _govHolidaysUrl,
      options: Options(
        contentType: 'application/json',
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    final raw = response.data;
    if (raw == null) return const [];
    final holidays = parseGovHolidayList(raw);
    holidays.sort((a, b) => a.date.compareTo(b.date));
    return holidays;
  }
}