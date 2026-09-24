// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "checkin")
  DateTime get checkin => throw _privateConstructorUsedError;
  @JsonKey(name: "checkout")
  DateTime get checkout => throw _privateConstructorUsedError;
  @JsonKey(name: "customerId")
  int get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: "roomId")
  int get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: "orderStatusId")
  int get orderStatusId => throw _privateConstructorUsedError;
  @JsonKey(name: "orderPlaceId")
  int get orderPlaceId => throw _privateConstructorUsedError;
  @JsonKey(name: "bnbId")
  int get bnbId => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: "depositPay")
  int get depositPay => throw _privateConstructorUsedError;
  @JsonKey(name: "memo")
  String get memo => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "created_at") DateTime createdAt,
      @JsonKey(name: "updated_at") DateTime updatedAt,
      @JsonKey(name: "checkin") DateTime checkin,
      @JsonKey(name: "checkout") DateTime checkout,
      @JsonKey(name: "customerId") int customerId,
      @JsonKey(name: "roomId") int roomId,
      @JsonKey(name: "orderStatusId") int orderStatusId,
      @JsonKey(name: "orderPlaceId") int orderPlaceId,
      @JsonKey(name: "bnbId") int bnbId,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "depositPay") int depositPay,
      @JsonKey(name: "memo") String memo});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? checkin = null,
    Object? checkout = null,
    Object? customerId = null,
    Object? roomId = null,
    Object? orderStatusId = null,
    Object? orderPlaceId = null,
    Object? bnbId = null,
    Object? price = null,
    Object? depositPay = null,
    Object? memo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkin: null == checkin
          ? _value.checkin
          : checkin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkout: null == checkout
          ? _value.checkout
          : checkout // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatusId: null == orderStatusId
          ? _value.orderStatusId
          : orderStatusId // ignore: cast_nullable_to_non_nullable
              as int,
      orderPlaceId: null == orderPlaceId
          ? _value.orderPlaceId
          : orderPlaceId // ignore: cast_nullable_to_non_nullable
              as int,
      bnbId: null == bnbId
          ? _value.bnbId
          : bnbId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      depositPay: null == depositPay
          ? _value.depositPay
          : depositPay // ignore: cast_nullable_to_non_nullable
              as int,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "created_at") DateTime createdAt,
      @JsonKey(name: "updated_at") DateTime updatedAt,
      @JsonKey(name: "checkin") DateTime checkin,
      @JsonKey(name: "checkout") DateTime checkout,
      @JsonKey(name: "customerId") int customerId,
      @JsonKey(name: "roomId") int roomId,
      @JsonKey(name: "orderStatusId") int orderStatusId,
      @JsonKey(name: "orderPlaceId") int orderPlaceId,
      @JsonKey(name: "bnbId") int bnbId,
      @JsonKey(name: "price") int price,
      @JsonKey(name: "depositPay") int depositPay,
      @JsonKey(name: "memo") String memo});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? checkin = null,
    Object? checkout = null,
    Object? customerId = null,
    Object? roomId = null,
    Object? orderStatusId = null,
    Object? orderPlaceId = null,
    Object? bnbId = null,
    Object? price = null,
    Object? depositPay = null,
    Object? memo = null,
  }) {
    return _then(_$OrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkin: null == checkin
          ? _value.checkin
          : checkin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checkout: null == checkout
          ? _value.checkout
          : checkout // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatusId: null == orderStatusId
          ? _value.orderStatusId
          : orderStatusId // ignore: cast_nullable_to_non_nullable
              as int,
      orderPlaceId: null == orderPlaceId
          ? _value.orderPlaceId
          : orderPlaceId // ignore: cast_nullable_to_non_nullable
              as int,
      bnbId: null == bnbId
          ? _value.bnbId
          : bnbId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      depositPay: null == depositPay
          ? _value.depositPay
          : depositPay // ignore: cast_nullable_to_non_nullable
              as int,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "updated_at") required this.updatedAt,
      @JsonKey(name: "checkin") required this.checkin,
      @JsonKey(name: "checkout") required this.checkout,
      @JsonKey(name: "customerId") required this.customerId,
      @JsonKey(name: "roomId") required this.roomId,
      @JsonKey(name: "orderStatusId") required this.orderStatusId,
      @JsonKey(name: "orderPlaceId") required this.orderPlaceId,
      @JsonKey(name: "bnbId") required this.bnbId,
      @JsonKey(name: "price") required this.price,
      @JsonKey(name: "depositPay") required this.depositPay,
      @JsonKey(name: "memo") this.memo = ''});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @override
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;
  @override
  @JsonKey(name: "checkin")
  final DateTime checkin;
  @override
  @JsonKey(name: "checkout")
  final DateTime checkout;
  @override
  @JsonKey(name: "customerId")
  final int customerId;
  @override
  @JsonKey(name: "roomId")
  final int roomId;
  @override
  @JsonKey(name: "orderStatusId")
  final int orderStatusId;
  @override
  @JsonKey(name: "orderPlaceId")
  final int orderPlaceId;
  @override
  @JsonKey(name: "bnbId")
  final int bnbId;
  @override
  @JsonKey(name: "price")
  final int price;
  @override
  @JsonKey(name: "depositPay")
  final int depositPay;
  @override
  @JsonKey(name: "memo")
  final String memo;

  @override
  String toString() {
    return 'Order(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, checkin: $checkin, checkout: $checkout, customerId: $customerId, roomId: $roomId, orderStatusId: $orderStatusId, orderPlaceId: $orderPlaceId, bnbId: $bnbId, price: $price, depositPay: $depositPay, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.checkin, checkin) || other.checkin == checkin) &&
            (identical(other.checkout, checkout) ||
                other.checkout == checkout) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.orderStatusId, orderStatusId) ||
                other.orderStatusId == orderStatusId) &&
            (identical(other.orderPlaceId, orderPlaceId) ||
                other.orderPlaceId == orderPlaceId) &&
            (identical(other.bnbId, bnbId) || other.bnbId == bnbId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.depositPay, depositPay) ||
                other.depositPay == depositPay) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      checkin,
      checkout,
      customerId,
      roomId,
      orderStatusId,
      orderPlaceId,
      bnbId,
      price,
      depositPay,
      memo);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "created_at") required final DateTime createdAt,
      @JsonKey(name: "updated_at") required final DateTime updatedAt,
      @JsonKey(name: "checkin") required final DateTime checkin,
      @JsonKey(name: "checkout") required final DateTime checkout,
      @JsonKey(name: "customerId") required final int customerId,
      @JsonKey(name: "roomId") required final int roomId,
      @JsonKey(name: "orderStatusId") required final int orderStatusId,
      @JsonKey(name: "orderPlaceId") required final int orderPlaceId,
      @JsonKey(name: "bnbId") required final int bnbId,
      @JsonKey(name: "price") required final int price,
      @JsonKey(name: "depositPay") required final int depositPay,
      @JsonKey(name: "memo") final String memo}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "created_at")
  DateTime get createdAt;
  @override
  @JsonKey(name: "updated_at")
  DateTime get updatedAt;
  @override
  @JsonKey(name: "checkin")
  DateTime get checkin;
  @override
  @JsonKey(name: "checkout")
  DateTime get checkout;
  @override
  @JsonKey(name: "customerId")
  int get customerId;
  @override
  @JsonKey(name: "roomId")
  int get roomId;
  @override
  @JsonKey(name: "orderStatusId")
  int get orderStatusId;
  @override
  @JsonKey(name: "orderPlaceId")
  int get orderPlaceId;
  @override
  @JsonKey(name: "bnbId")
  int get bnbId;
  @override
  @JsonKey(name: "price")
  int get price;
  @override
  @JsonKey(name: "depositPay")
  int get depositPay;
  @override
  @JsonKey(name: "memo")
  String get memo;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
