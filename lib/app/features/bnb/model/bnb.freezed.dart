// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bnb.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bnb _$BnbFromJson(Map<String, dynamic> json) {
  return _Bnb.fromJson(json);
}

/// @nodoc
mixin _$Bnb {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "bnbName")
  String? get bnbName => throw _privateConstructorUsedError;
  @JsonKey(name: "deposit")
  int? get deposit => throw _privateConstructorUsedError;
  @JsonKey(name: "depositPeriod")
  int? get depositPeriod => throw _privateConstructorUsedError;
  @JsonKey(name: "orderSample")
  dynamic get orderSample => throw _privateConstructorUsedError;
  @JsonKey(name: "activity")
  int? get activity => throw _privateConstructorUsedError;
  @JsonKey(name: "userId")
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "cancelSample")
  String? get cancelSample => throw _privateConstructorUsedError;
  @JsonKey(name: "delaySample")
  String? get delaySample => throw _privateConstructorUsedError;
  @JsonKey(name: "delay")
  int? get delay => throw _privateConstructorUsedError;
  @JsonKey(name: "checkSample")
  dynamic get checkSample => throw _privateConstructorUsedError;
  @JsonKey(name: "code")
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: "countryId")
  int? get countryId => throw _privateConstructorUsedError;
  @JsonKey(name: "cityId")
  int? get cityId => throw _privateConstructorUsedError;
  @JsonKey(name: "orders_count")
  int get ordersCount => throw _privateConstructorUsedError;

  /// Serializes this Bnb to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bnb
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BnbCopyWith<Bnb> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BnbCopyWith<$Res> {
  factory $BnbCopyWith(Bnb value, $Res Function(Bnb) then) =
      _$BnbCopyWithImpl<$Res, Bnb>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
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
      @JsonKey(name: "orders_count") int ordersCount});
}

/// @nodoc
class _$BnbCopyWithImpl<$Res, $Val extends Bnb> implements $BnbCopyWith<$Res> {
  _$BnbCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bnb
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? bnbName = freezed,
    Object? deposit = freezed,
    Object? depositPeriod = freezed,
    Object? orderSample = freezed,
    Object? activity = freezed,
    Object? userId = freezed,
    Object? cancelSample = freezed,
    Object? delaySample = freezed,
    Object? delay = freezed,
    Object? checkSample = freezed,
    Object? code = freezed,
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? ordersCount = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bnbName: freezed == bnbName
          ? _value.bnbName
          : bnbName // ignore: cast_nullable_to_non_nullable
              as String?,
      deposit: freezed == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int?,
      depositPeriod: freezed == depositPeriod
          ? _value.depositPeriod
          : depositPeriod // ignore: cast_nullable_to_non_nullable
              as int?,
      orderSample: freezed == orderSample
          ? _value.orderSample
          : orderSample // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      cancelSample: freezed == cancelSample
          ? _value.cancelSample
          : cancelSample // ignore: cast_nullable_to_non_nullable
              as String?,
      delaySample: freezed == delaySample
          ? _value.delaySample
          : delaySample // ignore: cast_nullable_to_non_nullable
              as String?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int?,
      checkSample: freezed == checkSample
          ? _value.checkSample
          : checkSample // ignore: cast_nullable_to_non_nullable
              as dynamic,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
      ordersCount: null == ordersCount
          ? _value.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BnbImplCopyWith<$Res> implements $BnbCopyWith<$Res> {
  factory _$$BnbImplCopyWith(_$BnbImpl value, $Res Function(_$BnbImpl) then) =
      __$$BnbImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
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
      @JsonKey(name: "orders_count") int ordersCount});
}

/// @nodoc
class __$$BnbImplCopyWithImpl<$Res> extends _$BnbCopyWithImpl<$Res, _$BnbImpl>
    implements _$$BnbImplCopyWith<$Res> {
  __$$BnbImplCopyWithImpl(_$BnbImpl _value, $Res Function(_$BnbImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bnb
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? bnbName = freezed,
    Object? deposit = freezed,
    Object? depositPeriod = freezed,
    Object? orderSample = freezed,
    Object? activity = freezed,
    Object? userId = freezed,
    Object? cancelSample = freezed,
    Object? delaySample = freezed,
    Object? delay = freezed,
    Object? checkSample = freezed,
    Object? code = freezed,
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? ordersCount = null,
  }) {
    return _then(_$BnbImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bnbName: freezed == bnbName
          ? _value.bnbName
          : bnbName // ignore: cast_nullable_to_non_nullable
              as String?,
      deposit: freezed == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int?,
      depositPeriod: freezed == depositPeriod
          ? _value.depositPeriod
          : depositPeriod // ignore: cast_nullable_to_non_nullable
              as int?,
      orderSample: freezed == orderSample
          ? _value.orderSample
          : orderSample // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      cancelSample: freezed == cancelSample
          ? _value.cancelSample
          : cancelSample // ignore: cast_nullable_to_non_nullable
              as String?,
      delaySample: freezed == delaySample
          ? _value.delaySample
          : delaySample // ignore: cast_nullable_to_non_nullable
              as String?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int?,
      checkSample: freezed == checkSample
          ? _value.checkSample
          : checkSample // ignore: cast_nullable_to_non_nullable
              as dynamic,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
      ordersCount: null == ordersCount
          ? _value.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BnbImpl implements _Bnb {
  const _$BnbImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "bnbName") this.bnbName,
      @JsonKey(name: "deposit") this.deposit,
      @JsonKey(name: "depositPeriod") this.depositPeriod,
      @JsonKey(name: "orderSample") this.orderSample,
      @JsonKey(name: "activity") this.activity,
      @JsonKey(name: "userId") this.userId,
      @JsonKey(name: "cancelSample") this.cancelSample,
      @JsonKey(name: "delaySample") this.delaySample,
      @JsonKey(name: "delay") this.delay,
      @JsonKey(name: "checkSample") this.checkSample,
      @JsonKey(name: "code") this.code,
      @JsonKey(name: "countryId") this.countryId,
      @JsonKey(name: "cityId") this.cityId,
      @JsonKey(name: "orders_count") this.ordersCount = 0});

  factory _$BnbImpl.fromJson(Map<String, dynamic> json) =>
      _$$BnbImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @override
  @JsonKey(name: "bnbName")
  final String? bnbName;
  @override
  @JsonKey(name: "deposit")
  final int? deposit;
  @override
  @JsonKey(name: "depositPeriod")
  final int? depositPeriod;
  @override
  @JsonKey(name: "orderSample")
  final dynamic orderSample;
  @override
  @JsonKey(name: "activity")
  final int? activity;
  @override
  @JsonKey(name: "userId")
  final int? userId;
  @override
  @JsonKey(name: "cancelSample")
  final String? cancelSample;
  @override
  @JsonKey(name: "delaySample")
  final String? delaySample;
  @override
  @JsonKey(name: "delay")
  final int? delay;
  @override
  @JsonKey(name: "checkSample")
  final dynamic checkSample;
  @override
  @JsonKey(name: "code")
  final String? code;
  @override
  @JsonKey(name: "countryId")
  final int? countryId;
  @override
  @JsonKey(name: "cityId")
  final int? cityId;
  @override
  @JsonKey(name: "orders_count")
  final int ordersCount;

  @override
  String toString() {
    return 'Bnb(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bnbName: $bnbName, deposit: $deposit, depositPeriod: $depositPeriod, orderSample: $orderSample, activity: $activity, userId: $userId, cancelSample: $cancelSample, delaySample: $delaySample, delay: $delay, checkSample: $checkSample, code: $code, countryId: $countryId, cityId: $cityId, ordersCount: $ordersCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BnbImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.bnbName, bnbName) || other.bnbName == bnbName) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.depositPeriod, depositPeriod) ||
                other.depositPeriod == depositPeriod) &&
            const DeepCollectionEquality()
                .equals(other.orderSample, orderSample) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cancelSample, cancelSample) ||
                other.cancelSample == cancelSample) &&
            (identical(other.delaySample, delaySample) ||
                other.delaySample == delaySample) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            const DeepCollectionEquality()
                .equals(other.checkSample, checkSample) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      bnbName,
      deposit,
      depositPeriod,
      const DeepCollectionEquality().hash(orderSample),
      activity,
      userId,
      cancelSample,
      delaySample,
      delay,
      const DeepCollectionEquality().hash(checkSample),
      code,
      countryId,
      cityId,
      ordersCount);

  /// Create a copy of Bnb
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BnbImplCopyWith<_$BnbImpl> get copyWith =>
      __$$BnbImplCopyWithImpl<_$BnbImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BnbImplToJson(
      this,
    );
  }
}

abstract class _Bnb implements Bnb {
  const factory _Bnb(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "created_at") final DateTime? createdAt,
      @JsonKey(name: "updated_at") final DateTime? updatedAt,
      @JsonKey(name: "bnbName") final String? bnbName,
      @JsonKey(name: "deposit") final int? deposit,
      @JsonKey(name: "depositPeriod") final int? depositPeriod,
      @JsonKey(name: "orderSample") final dynamic orderSample,
      @JsonKey(name: "activity") final int? activity,
      @JsonKey(name: "userId") final int? userId,
      @JsonKey(name: "cancelSample") final String? cancelSample,
      @JsonKey(name: "delaySample") final String? delaySample,
      @JsonKey(name: "delay") final int? delay,
      @JsonKey(name: "checkSample") final dynamic checkSample,
      @JsonKey(name: "code") final String? code,
      @JsonKey(name: "countryId") final int? countryId,
      @JsonKey(name: "cityId") final int? cityId,
      @JsonKey(name: "orders_count") final int ordersCount}) = _$BnbImpl;

  factory _Bnb.fromJson(Map<String, dynamic> json) = _$BnbImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt;
  @override
  @JsonKey(name: "updated_at")
  DateTime? get updatedAt;
  @override
  @JsonKey(name: "bnbName")
  String? get bnbName;
  @override
  @JsonKey(name: "deposit")
  int? get deposit;
  @override
  @JsonKey(name: "depositPeriod")
  int? get depositPeriod;
  @override
  @JsonKey(name: "orderSample")
  dynamic get orderSample;
  @override
  @JsonKey(name: "activity")
  int? get activity;
  @override
  @JsonKey(name: "userId")
  int? get userId;
  @override
  @JsonKey(name: "cancelSample")
  String? get cancelSample;
  @override
  @JsonKey(name: "delaySample")
  String? get delaySample;
  @override
  @JsonKey(name: "delay")
  int? get delay;
  @override
  @JsonKey(name: "checkSample")
  dynamic get checkSample;
  @override
  @JsonKey(name: "code")
  String? get code;
  @override
  @JsonKey(name: "countryId")
  int? get countryId;
  @override
  @JsonKey(name: "cityId")
  int? get cityId;
  @override
  @JsonKey(name: "orders_count")
  int get ordersCount;

  /// Create a copy of Bnb
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BnbImplCopyWith<_$BnbImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
