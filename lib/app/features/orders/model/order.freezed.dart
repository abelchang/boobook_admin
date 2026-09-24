// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {

@JsonKey(name: "id") int get id;@JsonKey(name: "created_at") DateTime get createdAt;@JsonKey(name: "updated_at") DateTime get updatedAt;@JsonKey(name: "checkin") DateTime get checkin;@JsonKey(name: "checkout") DateTime get checkout;@JsonKey(name: "customerId") int get customerId;@JsonKey(name: "roomId") int get roomId;@JsonKey(name: "orderStatusId") int get orderStatusId;@JsonKey(name: "orderPlaceId") int get orderPlaceId;@JsonKey(name: "bnbId") int get bnbId;@JsonKey(name: "price") int get price;@JsonKey(name: "depositPay") int get depositPay;@JsonKey(name: "memo") String get memo;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.checkin, _this.checkin) || other.checkin == _this.checkin)&&(identical(other.checkout, _this.checkout) || other.checkout == _this.checkout)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.orderStatusId, _this.orderStatusId) || other.orderStatusId == _this.orderStatusId)&&(identical(other.orderPlaceId, _this.orderPlaceId) || other.orderPlaceId == _this.orderPlaceId)&&(identical(other.bnbId, _this.bnbId) || other.bnbId == _this.bnbId)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.depositPay, _this.depositPay) || other.depositPay == _this.depositPay)&&(identical(other.memo, _this.memo) || other.memo == _this.memo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.updatedAt,_this.checkin,_this.checkout,_this.customerId,_this.roomId,_this.orderStatusId,_this.orderPlaceId,_this.bnbId,_this.price,_this.depositPay,_this.memo);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(id: ${_this.id}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, checkin: ${_this.checkin}, checkout: ${_this.checkout}, customerId: ${_this.customerId}, roomId: ${_this.roomId}, orderStatusId: ${_this.orderStatusId}, orderPlaceId: ${_this.orderPlaceId}, bnbId: ${_this.bnbId}, price: ${_this.price}, depositPay: ${_this.depositPay}, memo: ${_this.memo})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "created_at") DateTime createdAt,@JsonKey(name: "updated_at") DateTime updatedAt,@JsonKey(name: "checkin") DateTime checkin,@JsonKey(name: "checkout") DateTime checkout,@JsonKey(name: "customerId") int customerId,@JsonKey(name: "roomId") int roomId,@JsonKey(name: "orderStatusId") int orderStatusId,@JsonKey(name: "orderPlaceId") int orderPlaceId,@JsonKey(name: "bnbId") int bnbId,@JsonKey(name: "price") int price,@JsonKey(name: "depositPay") int depositPay,@JsonKey(name: "memo") String memo
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? updatedAt = null,Object? checkin = null,Object? checkout = null,Object? customerId = null,Object? roomId = null,Object? orderStatusId = null,Object? orderPlaceId = null,Object? bnbId = null,Object? price = null,Object? depositPay = null,Object? memo = null,}) {
  return _then(Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,checkin: null == checkin ? _self.checkin : checkin // ignore: cast_nullable_to_non_nullable
as DateTime,checkout: null == checkout ? _self.checkout : checkout // ignore: cast_nullable_to_non_nullable
as DateTime,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,orderStatusId: null == orderStatusId ? _self.orderStatusId : orderStatusId // ignore: cast_nullable_to_non_nullable
as int,orderPlaceId: null == orderPlaceId ? _self.orderPlaceId : orderPlaceId // ignore: cast_nullable_to_non_nullable
as int,bnbId: null == bnbId ? _self.bnbId : bnbId // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,depositPay: null == depositPay ? _self.depositPay : depositPay // ignore: cast_nullable_to_non_nullable
as int,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "created_at")  DateTime createdAt, @JsonKey(name: "updated_at")  DateTime updatedAt, @JsonKey(name: "checkin")  DateTime checkin, @JsonKey(name: "checkout")  DateTime checkout, @JsonKey(name: "customerId")  int customerId, @JsonKey(name: "roomId")  int roomId, @JsonKey(name: "orderStatusId")  int orderStatusId, @JsonKey(name: "orderPlaceId")  int orderPlaceId, @JsonKey(name: "bnbId")  int bnbId, @JsonKey(name: "price")  int price, @JsonKey(name: "depositPay")  int depositPay, @JsonKey(name: "memo")  String memo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.checkin,_that.checkout,_that.customerId,_that.roomId,_that.orderStatusId,_that.orderPlaceId,_that.bnbId,_that.price,_that.depositPay,_that.memo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "created_at")  DateTime createdAt, @JsonKey(name: "updated_at")  DateTime updatedAt, @JsonKey(name: "checkin")  DateTime checkin, @JsonKey(name: "checkout")  DateTime checkout, @JsonKey(name: "customerId")  int customerId, @JsonKey(name: "roomId")  int roomId, @JsonKey(name: "orderStatusId")  int orderStatusId, @JsonKey(name: "orderPlaceId")  int orderPlaceId, @JsonKey(name: "bnbId")  int bnbId, @JsonKey(name: "price")  int price, @JsonKey(name: "depositPay")  int depositPay, @JsonKey(name: "memo")  String memo)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.checkin,_that.checkout,_that.customerId,_that.roomId,_that.orderStatusId,_that.orderPlaceId,_that.bnbId,_that.price,_that.depositPay,_that.memo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int id, @JsonKey(name: "created_at")  DateTime createdAt, @JsonKey(name: "updated_at")  DateTime updatedAt, @JsonKey(name: "checkin")  DateTime checkin, @JsonKey(name: "checkout")  DateTime checkout, @JsonKey(name: "customerId")  int customerId, @JsonKey(name: "roomId")  int roomId, @JsonKey(name: "orderStatusId")  int orderStatusId, @JsonKey(name: "orderPlaceId")  int orderPlaceId, @JsonKey(name: "bnbId")  int bnbId, @JsonKey(name: "price")  int price, @JsonKey(name: "depositPay")  int depositPay, @JsonKey(name: "memo")  String memo)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.checkin,_that.checkout,_that.customerId,_that.roomId,_that.orderStatusId,_that.orderPlaceId,_that.bnbId,_that.price,_that.depositPay,_that.memo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({@JsonKey(name: "id") required this.id, @JsonKey(name: "created_at") required this.createdAt, @JsonKey(name: "updated_at") required this.updatedAt, @JsonKey(name: "checkin") required this.checkin, @JsonKey(name: "checkout") required this.checkout, @JsonKey(name: "customerId") required this.customerId, @JsonKey(name: "roomId") required this.roomId, @JsonKey(name: "orderStatusId") required this.orderStatusId, @JsonKey(name: "orderPlaceId") required this.orderPlaceId, @JsonKey(name: "bnbId") required this.bnbId, @JsonKey(name: "price") required this.price, @JsonKey(name: "depositPay") required this.depositPay, @JsonKey(name: "memo") this.memo = ''});
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override@JsonKey(name: "id") final  int id;
@override@JsonKey(name: "created_at") final  DateTime createdAt;
@override@JsonKey(name: "updated_at") final  DateTime updatedAt;
@override@JsonKey(name: "checkin") final  DateTime checkin;
@override@JsonKey(name: "checkout") final  DateTime checkout;
@override@JsonKey(name: "customerId") final  int customerId;
@override@JsonKey(name: "roomId") final  int roomId;
@override@JsonKey(name: "orderStatusId") final  int orderStatusId;
@override@JsonKey(name: "orderPlaceId") final  int orderPlaceId;
@override@JsonKey(name: "bnbId") final  int bnbId;
@override@JsonKey(name: "price") final  int price;
@override@JsonKey(name: "depositPay") final  int depositPay;
@override@JsonKey(name: "memo") final  String memo;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.checkin, checkin) || other.checkin == checkin)&&(identical(other.checkout, checkout) || other.checkout == checkout)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.orderStatusId, orderStatusId) || other.orderStatusId == orderStatusId)&&(identical(other.orderPlaceId, orderPlaceId) || other.orderPlaceId == orderPlaceId)&&(identical(other.bnbId, bnbId) || other.bnbId == bnbId)&&(identical(other.price, price) || other.price == price)&&(identical(other.depositPay, depositPay) || other.depositPay == depositPay)&&(identical(other.memo, memo) || other.memo == memo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,updatedAt,checkin,checkout,customerId,roomId,orderStatusId,orderPlaceId,bnbId,price,depositPay,memo);
}

@override
String toString() {
    return 'Order(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, checkin: $checkin, checkout: $checkout, customerId: $customerId, roomId: $roomId, orderStatusId: $orderStatusId, orderPlaceId: $orderPlaceId, bnbId: $bnbId, price: $price, depositPay: $depositPay, memo: $memo)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "created_at") DateTime createdAt,@JsonKey(name: "updated_at") DateTime updatedAt,@JsonKey(name: "checkin") DateTime checkin,@JsonKey(name: "checkout") DateTime checkout,@JsonKey(name: "customerId") int customerId,@JsonKey(name: "roomId") int roomId,@JsonKey(name: "orderStatusId") int orderStatusId,@JsonKey(name: "orderPlaceId") int orderPlaceId,@JsonKey(name: "bnbId") int bnbId,@JsonKey(name: "price") int price,@JsonKey(name: "depositPay") int depositPay,@JsonKey(name: "memo") String memo
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? updatedAt = null,Object? checkin = null,Object? checkout = null,Object? customerId = null,Object? roomId = null,Object? orderStatusId = null,Object? orderPlaceId = null,Object? bnbId = null,Object? price = null,Object? depositPay = null,Object? memo = null,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,checkin: null == checkin ? _self.checkin : checkin // ignore: cast_nullable_to_non_nullable
as DateTime,checkout: null == checkout ? _self.checkout : checkout // ignore: cast_nullable_to_non_nullable
as DateTime,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,orderStatusId: null == orderStatusId ? _self.orderStatusId : orderStatusId // ignore: cast_nullable_to_non_nullable
as int,orderPlaceId: null == orderPlaceId ? _self.orderPlaceId : orderPlaceId // ignore: cast_nullable_to_non_nullable
as int,bnbId: null == bnbId ? _self.bnbId : bnbId // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,depositPay: null == depositPay ? _self.depositPay : depositPay // ignore: cast_nullable_to_non_nullable
as int,memo: null == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
