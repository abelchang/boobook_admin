import 'package:freezed_annotation/freezed_annotation.dart';

part 'solar.freezed.dart';
part 'solar.g.dart';

@freezed
abstract class Solar with _$Solar {
  const factory Solar({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "date") required DateTime date,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "generated_at") DateTime? generatedAt,
  }) = _Solar;

  factory Solar.fromJson(Map<String, dynamic> json) => _$SolarFromJson(json);
}