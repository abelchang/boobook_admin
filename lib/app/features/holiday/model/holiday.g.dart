// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Holiday _$HolidayFromJson(Map<String, dynamic> json) => _Holiday(
  id: (json['id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  date: DateTime.parse(json['date'] as String),
  name: json['name'] as String,
  isHoliday: boolFromInt((json['isHoliday'] as num).toInt()),
  holidayCategory: json['holidayCategory'] as String?,
  description: json['description'] as String?,
  tep: json['tep'] == null ? false : boolFromInt((json['tep'] as num).toInt()),
);

Map<String, dynamic> _$HolidayToJson(_Holiday instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'date': instance.date.toIso8601String(),
  'name': instance.name,
  'isHoliday': boolToInt(instance.isHoliday),
  'holidayCategory': instance.holidayCategory,
  'description': instance.description,
  'tep': boolToInt(instance.tep),
};
