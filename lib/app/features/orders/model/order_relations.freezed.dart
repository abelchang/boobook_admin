// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_relations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderRoom {

@JsonKey(name: "id") int get id;@JsonKey(name: "roomName") String get roomName;
/// Create a copy of OrderRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderRoomCopyWith<OrderRoom> get copyWith => _$OrderRoomCopyWithImpl<OrderRoom>(this as OrderRoom, _$identity);

  /// Serializes this OrderRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderRoom;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderRoom&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomName, _this.roomName) || other.roomName == _this.roomName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderRoom;
  return Object.hash(runtimeType,_this.id,_this.roomName);
}

@override
String toString() {
  final _this = this as OrderRoom;
  return 'OrderRoom(id: ${_this.id}, roomName: ${_this.roomName})';
}


}

/// @nodoc
abstract mixin class $OrderRoomCopyWith<$Res>  {
  factory $OrderRoomCopyWith(OrderRoom value, $Res Function(OrderRoom) _then) = _$OrderRoomCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "roomName") String roomName
});




}
/// @nodoc
class _$OrderRoomCopyWithImpl<$Res>
    implements $OrderRoomCopyWith<$Res> {
  _$OrderRoomCopyWithImpl(this._self, this._then);

  final OrderRoom _self;
  final $Res Function(OrderRoom) _then;

/// Create a copy of OrderRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomName = null,}) {
  return _then(OrderRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderRoom].
extension OrderRoomPatterns on OrderRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderRoom value)  $default,){
final _that = this;
switch (_that) {
case _OrderRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderRoom value)?  $default,){
final _that = this;
switch (_that) {
case _OrderRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "roomName")  String roomName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderRoom() when $default != null:
return $default(_that.id,_that.roomName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "roomName")  String roomName)  $default,) {final _that = this;
switch (_that) {
case _OrderRoom():
return $default(_that.id,_that.roomName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int id, @JsonKey(name: "roomName")  String roomName)?  $default,) {final _that = this;
switch (_that) {
case _OrderRoom() when $default != null:
return $default(_that.id,_that.roomName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderRoom implements OrderRoom {
  const _OrderRoom({@JsonKey(name: "id") required this.id, @JsonKey(name: "roomName") this.roomName = ''});
  factory _OrderRoom.fromJson(Map<String, dynamic> json) => _$OrderRoomFromJson(json);

@override@JsonKey(name: "id") final  int id;
@override@JsonKey(name: "roomName") final  String roomName;

/// Create a copy of OrderRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderRoomCopyWith<_OrderRoom> get copyWith => __$OrderRoomCopyWithImpl<_OrderRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderRoomToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.roomName, roomName) || other.roomName == roomName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomName);
}

@override
String toString() {
    return 'OrderRoom(id: $id, roomName: $roomName)';
}


}

/// @nodoc
abstract mixin class _$OrderRoomCopyWith<$Res> implements $OrderRoomCopyWith<$Res> {
  factory _$OrderRoomCopyWith(_OrderRoom value, $Res Function(_OrderRoom) _then) = __$OrderRoomCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "roomName") String roomName
});




}
/// @nodoc
class __$OrderRoomCopyWithImpl<$Res>
    implements _$OrderRoomCopyWith<$Res> {
  __$OrderRoomCopyWithImpl(this._self, this._then);

  final _OrderRoom _self;
  final $Res Function(_OrderRoom) _then;

/// Create a copy of OrderRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomName = null,}) {
  return _then(_OrderRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,roomName: null == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OrderPlace {

@JsonKey(name: "id") int get id;@JsonKey(name: "orderPlace") String get orderPlace;
/// Create a copy of OrderPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderPlaceCopyWith<OrderPlace> get copyWith => _$OrderPlaceCopyWithImpl<OrderPlace>(this as OrderPlace, _$identity);

  /// Serializes this OrderPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orderPlace, _this.orderPlace) || other.orderPlace == _this.orderPlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderPlace;
  return Object.hash(runtimeType,_this.id,_this.orderPlace);
}

@override
String toString() {
  final _this = this as OrderPlace;
  return 'OrderPlace(id: ${_this.id}, orderPlace: ${_this.orderPlace})';
}


}

/// @nodoc
abstract mixin class $OrderPlaceCopyWith<$Res>  {
  factory $OrderPlaceCopyWith(OrderPlace value, $Res Function(OrderPlace) _then) = _$OrderPlaceCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "orderPlace") String orderPlace
});




}
/// @nodoc
class _$OrderPlaceCopyWithImpl<$Res>
    implements $OrderPlaceCopyWith<$Res> {
  _$OrderPlaceCopyWithImpl(this._self, this._then);

  final OrderPlace _self;
  final $Res Function(OrderPlace) _then;

/// Create a copy of OrderPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderPlace = null,}) {
  return _then(OrderPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderPlace: null == orderPlace ? _self.orderPlace : orderPlace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderPlace].
extension OrderPlacePatterns on OrderPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderPlace value)  $default,){
final _that = this;
switch (_that) {
case _OrderPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderPlace value)?  $default,){
final _that = this;
switch (_that) {
case _OrderPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "orderPlace")  String orderPlace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderPlace() when $default != null:
return $default(_that.id,_that.orderPlace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "orderPlace")  String orderPlace)  $default,) {final _that = this;
switch (_that) {
case _OrderPlace():
return $default(_that.id,_that.orderPlace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int id, @JsonKey(name: "orderPlace")  String orderPlace)?  $default,) {final _that = this;
switch (_that) {
case _OrderPlace() when $default != null:
return $default(_that.id,_that.orderPlace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderPlace implements OrderPlace {
  const _OrderPlace({@JsonKey(name: "id") required this.id, @JsonKey(name: "orderPlace") this.orderPlace = ''});
  factory _OrderPlace.fromJson(Map<String, dynamic> json) => _$OrderPlaceFromJson(json);

@override@JsonKey(name: "id") final  int id;
@override@JsonKey(name: "orderPlace") final  String orderPlace;

/// Create a copy of OrderPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPlaceCopyWith<_OrderPlace> get copyWith => __$OrderPlaceCopyWithImpl<_OrderPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.orderPlace, orderPlace) || other.orderPlace == orderPlace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,orderPlace);
}

@override
String toString() {
    return 'OrderPlace(id: $id, orderPlace: $orderPlace)';
}


}

/// @nodoc
abstract mixin class _$OrderPlaceCopyWith<$Res> implements $OrderPlaceCopyWith<$Res> {
  factory _$OrderPlaceCopyWith(_OrderPlace value, $Res Function(_OrderPlace) _then) = __$OrderPlaceCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "orderPlace") String orderPlace
});




}
/// @nodoc
class __$OrderPlaceCopyWithImpl<$Res>
    implements _$OrderPlaceCopyWith<$Res> {
  __$OrderPlaceCopyWithImpl(this._self, this._then);

  final _OrderPlace _self;
  final $Res Function(_OrderPlace) _then;

/// Create a copy of OrderPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderPlace = null,}) {
  return _then(_OrderPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderPlace: null == orderPlace ? _self.orderPlace : orderPlace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OrderCustomer {

@JsonKey(name: "id") int get id;@JsonKey(name: "customerName") String get customerName;@JsonKey(name: "phone") String get phone;
/// Create a copy of OrderCustomer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCustomerCopyWith<OrderCustomer> get copyWith => _$OrderCustomerCopyWithImpl<OrderCustomer>(this as OrderCustomer, _$identity);

  /// Serializes this OrderCustomer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderCustomer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderCustomer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderCustomer;
  return Object.hash(runtimeType,_this.id,_this.customerName,_this.phone);
}

@override
String toString() {
  final _this = this as OrderCustomer;
  return 'OrderCustomer(id: ${_this.id}, customerName: ${_this.customerName}, phone: ${_this.phone})';
}


}

/// @nodoc
abstract mixin class $OrderCustomerCopyWith<$Res>  {
  factory $OrderCustomerCopyWith(OrderCustomer value, $Res Function(OrderCustomer) _then) = _$OrderCustomerCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "customerName") String customerName,@JsonKey(name: "phone") String phone
});




}
/// @nodoc
class _$OrderCustomerCopyWithImpl<$Res>
    implements $OrderCustomerCopyWith<$Res> {
  _$OrderCustomerCopyWithImpl(this._self, this._then);

  final OrderCustomer _self;
  final $Res Function(OrderCustomer) _then;

/// Create a copy of OrderCustomer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerName = null,Object? phone = null,}) {
  return _then(OrderCustomer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderCustomer].
extension OrderCustomerPatterns on OrderCustomer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderCustomer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderCustomer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderCustomer value)  $default,){
final _that = this;
switch (_that) {
case _OrderCustomer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderCustomer value)?  $default,){
final _that = this;
switch (_that) {
case _OrderCustomer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "customerName")  String customerName, @JsonKey(name: "phone")  String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderCustomer() when $default != null:
return $default(_that.id,_that.customerName,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int id, @JsonKey(name: "customerName")  String customerName, @JsonKey(name: "phone")  String phone)  $default,) {final _that = this;
switch (_that) {
case _OrderCustomer():
return $default(_that.id,_that.customerName,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int id, @JsonKey(name: "customerName")  String customerName, @JsonKey(name: "phone")  String phone)?  $default,) {final _that = this;
switch (_that) {
case _OrderCustomer() when $default != null:
return $default(_that.id,_that.customerName,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderCustomer implements OrderCustomer {
  const _OrderCustomer({@JsonKey(name: "id") required this.id, @JsonKey(name: "customerName") this.customerName = '', @JsonKey(name: "phone") this.phone = ''});
  factory _OrderCustomer.fromJson(Map<String, dynamic> json) => _$OrderCustomerFromJson(json);

@override@JsonKey(name: "id") final  int id;
@override@JsonKey(name: "customerName") final  String customerName;
@override@JsonKey(name: "phone") final  String phone;

/// Create a copy of OrderCustomer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCustomerCopyWith<_OrderCustomer> get copyWith => __$OrderCustomerCopyWithImpl<_OrderCustomer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderCustomerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderCustomer&&(identical(other.id, id) || other.id == id)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,customerName,phone);
}

@override
String toString() {
    return 'OrderCustomer(id: $id, customerName: $customerName, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$OrderCustomerCopyWith<$Res> implements $OrderCustomerCopyWith<$Res> {
  factory _$OrderCustomerCopyWith(_OrderCustomer value, $Res Function(_OrderCustomer) _then) = __$OrderCustomerCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int id,@JsonKey(name: "customerName") String customerName,@JsonKey(name: "phone") String phone
});




}
/// @nodoc
class __$OrderCustomerCopyWithImpl<$Res>
    implements _$OrderCustomerCopyWith<$Res> {
  __$OrderCustomerCopyWithImpl(this._self, this._then);

  final _OrderCustomer _self;
  final $Res Function(_OrderCustomer) _then;

/// Create a copy of OrderCustomer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerName = null,Object? phone = null,}) {
  return _then(_OrderCustomer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
