// To parse this JSON data, do
//
//     final bnb = bnbFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'bnb.freezed.dart';
part 'bnb.g.dart';

Bnb bnbFromJson(String str) => Bnb.fromJson(json.decode(str));

String bnbToJson(Bnb data) => json.encode(data.toJson());

@freezed
class Bnb with _$Bnb {
  const factory Bnb({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "bnbName") String? bnbName,
    @JsonKey(name: "deposit") int? deposit,
    @JsonKey(name: "depositPeriod") int? depositPeriod,
    @JsonKey(name: "orderSample") dynamic orderSample,
    @JsonKey(name: "activity") int? activity,
    @JsonKey(name: "userId") int? userId,
    @JsonKey(name: "cancelSample") String? cancelSample,
    @JsonKey(name: "delaySample") String? delaySample,
    @JsonKey(name: "delay") int? delay,
    @JsonKey(name: "checkSample") dynamic checkSample,
    @JsonKey(name: "code") String? code,
    @JsonKey(name: "countryId") int? countryId,
    @JsonKey(name: "cityId") int? cityId,
    @JsonKey(name: "orders_count") @Default(0) int ordersCount,
  }) = _Bnb;

  factory Bnb.fromJson(Map<String, dynamic> json) => _$BnbFromJson(json);
}
