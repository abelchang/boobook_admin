// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Solar _$SolarFromJson(Map<String, dynamic> json) => _Solar(
  id: (json['id'] as num?)?.toInt(),
  date: DateTime.parse(json['date'] as String),
  name: json['name'] as String,
  description: json['description'] as String?,
  generatedAt: json['generated_at'] == null
      ? null
      : DateTime.parse(json['generated_at'] as String),
);

Map<String, dynamic> _$SolarToJson(_Solar instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'name': instance.name,
  'description': instance.description,
  'generated_at': instance.generatedAt?.toIso8601String(),
};
