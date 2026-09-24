// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bnb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BnbImpl _$$BnbImplFromJson(Map<String, dynamic> json) => _$BnbImpl(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      bnbName: json['bnbName'] as String?,
      deposit: (json['deposit'] as num?)?.toInt(),
      depositPeriod: (json['depositPeriod'] as num?)?.toInt(),
      orderSample: json['orderSample'],
      activity: (json['activity'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      cancelSample: json['cancelSample'] as String?,
      delaySample: json['delaySample'] as String?,
      delay: (json['delay'] as num?)?.toInt(),
      checkSample: json['checkSample'],
      code: json['code'] as String?,
      countryId: (json['countryId'] as num?)?.toInt(),
      cityId: (json['cityId'] as num?)?.toInt(),
      ordersCount: (json['orders_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BnbImplToJson(_$BnbImpl instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'bnbName': instance.bnbName,
      'deposit': instance.deposit,
      'depositPeriod': instance.depositPeriod,
      'orderSample': instance.orderSample,
      'activity': instance.activity,
      'userId': instance.userId,
      'cancelSample': instance.cancelSample,
      'delaySample': instance.delaySample,
      'delay': instance.delay,
      'checkSample': instance.checkSample,
      'code': instance.code,
      'countryId': instance.countryId,
      'cityId': instance.cityId,
      'orders_count': instance.ordersCount,
    };
