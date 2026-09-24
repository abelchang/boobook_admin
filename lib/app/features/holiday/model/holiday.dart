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
class Holiday with _$Holiday {
  const factory Holiday({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "date") required DateTime date,
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
