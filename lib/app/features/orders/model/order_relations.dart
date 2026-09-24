import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_relations.freezed.dart';
part 'order_relations.g.dart';

/// 訂單關聯：房型（admin 只取名稱顯示用）。
@freezed
abstract class OrderRoom with _$OrderRoom {
  const factory OrderRoom({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "roomName") @Default('') String roomName,
  }) = _OrderRoom;

  factory OrderRoom.fromJson(Map<String, dynamic> json) =>
      _$OrderRoomFromJson(json);
}

/// 訂單關聯：訂單來源（通路）。
@freezed
abstract class OrderPlace with _$OrderPlace {
  const factory OrderPlace({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "orderPlace") @Default('') String orderPlace,
  }) = _OrderPlace;

  factory OrderPlace.fromJson(Map<String, dynamic> json) =>
      _$OrderPlaceFromJson(json);
}

/// 訂單關聯：客戶（明細頁顯示姓名／電話用）。
@freezed
abstract class OrderCustomer with _$OrderCustomer {
  const factory OrderCustomer({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "customerName") @Default('') String customerName,
    @JsonKey(name: "phone") @Default('') String phone,
  }) = _OrderCustomer;

  factory OrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$OrderCustomerFromJson(json);
}

/// 民宿的訂單參考資料：房型＋通路段。
/// 房型／通路數量小且近乎靜態，進月份明細頁時整批載入一次，
/// 之後所有訂單卡片共用這兩個列表做 id → 名稱對照。
class OrderReferences {
  const OrderReferences({required this.rooms, required this.places});

  final List<OrderRoom> rooms;
  final List<OrderPlace> places;
}