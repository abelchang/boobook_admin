// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'order.freezed.dart';
part 'order.g.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

@freezed
abstract class Order with _$Order {
  const factory Order({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "updated_at") required DateTime updatedAt,
    @JsonKey(name: "checkin") required DateTime checkin,
    @JsonKey(name: "checkout") required DateTime checkout,
    @JsonKey(name: "customerId") required int customerId,
    @JsonKey(name: "roomId") required int roomId,
    @JsonKey(name: "orderStatusId") required int orderStatusId,
    @JsonKey(name: "orderPlaceId") required int orderPlaceId,
    @JsonKey(name: "bnbId") required int bnbId,
    @JsonKey(name: "price") required int price,
    @JsonKey(name: "depositPay") required int depositPay,
    @JsonKey(name: "memo") @Default('') String memo,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
