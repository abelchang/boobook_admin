// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_relations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderRoom _$OrderRoomFromJson(Map<String, dynamic> json) => _OrderRoom(
  id: (json['id'] as num).toInt(),
  roomName: json['roomName'] as String? ?? '',
);

Map<String, dynamic> _$OrderRoomToJson(_OrderRoom instance) =>
    <String, dynamic>{'id': instance.id, 'roomName': instance.roomName};

_OrderPlace _$OrderPlaceFromJson(Map<String, dynamic> json) => _OrderPlace(
  id: (json['id'] as num).toInt(),
  orderPlace: json['orderPlace'] as String? ?? '',
);

Map<String, dynamic> _$OrderPlaceToJson(_OrderPlace instance) =>
    <String, dynamic>{'id': instance.id, 'orderPlace': instance.orderPlace};

_OrderCustomer _$OrderCustomerFromJson(Map<String, dynamic> json) =>
    _OrderCustomer(
      id: (json['id'] as num).toInt(),
      customerName: json['customerName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$OrderCustomerToJson(_OrderCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'phone': instance.phone,
    };
