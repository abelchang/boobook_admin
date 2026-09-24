// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      checkin: DateTime.parse(json['checkin'] as String),
      checkout: DateTime.parse(json['checkout'] as String),
      customerId: (json['customerId'] as num).toInt(),
      roomId: (json['roomId'] as num).toInt(),
      orderStatusId: (json['orderStatusId'] as num).toInt(),
      orderPlaceId: (json['orderPlaceId'] as num).toInt(),
      bnbId: (json['bnbId'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      depositPay: (json['depositPay'] as num).toInt(),
      memo: json['memo'] as String? ?? '',
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'checkin': instance.checkin.toIso8601String(),
      'checkout': instance.checkout.toIso8601String(),
      'customerId': instance.customerId,
      'roomId': instance.roomId,
      'orderStatusId': instance.orderStatusId,
      'orderPlaceId': instance.orderPlaceId,
      'bnbId': instance.bnbId,
      'price': instance.price,
      'depositPay': instance.depositPay,
      'memo': instance.memo,
    };
