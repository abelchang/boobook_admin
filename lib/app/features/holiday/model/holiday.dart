// To parse this JSON data, do
//
//     final holiday = holidayFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'holiday.freezed.dart';
part 'holiday.g.dart';

Holiday holidayFromJson(String str) => Holiday.fromJson(json.decode(str));

String holidayToJson(Holiday data) => json.encode(data.toJson());

@freezed
abstract class Holiday with _$Holiday {
  const factory Holiday({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "date", toJson: dateToJson) required DateTime date,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
    required bool isHoliday,
    @JsonKey(name: "holidayCategory") String? holidayCategory,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
    @Default(false)
    bool tep,
  }) = _Holiday;

  factory Holiday.fromJson(Map<String, dynamic> json) =>
      _$HolidayFromJson(json);
}

bool boolFromInt(int done) => done == 1;

int boolToInt(bool done) => done ? 1 : 0;

/// 序列化時輸出純 `yyyy-MM-dd`（不要 ISO 時間戳——後端以字串比對 date 做去重，
/// `2026-01-01 !== 2026-01-01T00:00:00.000` 會打破依日期的 upsert 判斷）。
String dateToJson(DateTime d) => d.toIso8601String().substring(0, 10);
