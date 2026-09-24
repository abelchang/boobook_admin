// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bnb.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bnb {

@JsonKey(name: "id") int? get id;@JsonKey(name: "created_at") DateTime? get createdAt;@JsonKey(name: "updated_at") DateTime? get updatedAt;@JsonKey(name: "bnbName") String? get bnbName;@JsonKey(name: "deposit") int? get deposit;@JsonKey(name: "depositPeriod") int? get depositPeriod;@JsonKey(name: "orderSample") dynamic get orderSample;@JsonKey(name: "activity") int? get activity;@JsonKey(name: "userId") int? get userId;@JsonKey(name: "cancelSample") String? get cancelSample;@JsonKey(name: "delaySample") String? get delaySample;@JsonKey(name: "delay") int? get delay;@JsonKey(name: "checkSample") dynamic get checkSample;@JsonKey(name: "code") String? get code;@JsonKey(name: "countryId") int? get countryId;@JsonKey(name: "cityId") int? get cityId;@JsonKey(name: "orders_count") int get ordersCount;@JsonKey(name: "revenue_effective") int? get revenueEffective;
/// Create a copy of Bnb
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BnbCopyWith<Bnb> get copyWith => _$BnbCopyWithImpl<Bnb>(this as Bnb, _$identity);

  /// Serializes this Bnb to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Bnb;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bnb&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.bnbName, _this.bnbName) || other.bnbName == _this.bnbName)&&(identical(other.deposit, _this.deposit) || other.deposit == _this.deposit)&&(identical(other.depositPeriod, _this.depositPeriod) || other.depositPeriod == _this.depositPeriod)&&const DeepCollectionEquality().equals(other.orderSample, _this.orderSample)&&(identical(other.activity, _this.activity) || other.activity == _this.activity)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.cancelSample, _this.cancelSample) || other.cancelSample == _this.cancelSample)&&(identical(other.delaySample, _this.delaySample) || other.delaySample == _this.delaySample)&&(identical(other.delay, _this.delay) || other.delay == _this.delay)&&const DeepCollectionEquality().equals(other.checkSample, _this.checkSample)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.countryId, _this.countryId) || other.countryId == _this.countryId)&&(identical(other.cityId, _this.cityId) || other.cityId == _this.cityId)&&(identical(other.ordersCount, _this.ordersCount) || other.ordersCount == _this.ordersCount)&&(identical(other.revenueEffective, _this.revenueEffective) || other.revenueEffective == _this.revenueEffective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Bnb;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.updatedAt,_this.bnbName,_this.deposit,_this.depositPeriod,const DeepCollectionEquality().hash(_this.orderSample),_this.activity,_this.userId,_this.cancelSample,_this.delaySample,_this.delay,const DeepCollectionEquality().hash(_this.checkSample),_this.code,_this.countryId,_this.cityId,_this.ordersCount,_this.revenueEffective);
}

@override
String toString() {
  final _this = this as Bnb;
  return 'Bnb(id: ${_this.id}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, bnbName: ${_this.bnbName}, deposit: ${_this.deposit}, depositPeriod: ${_this.depositPeriod}, orderSample: ${_this.orderSample}, activity: ${_this.activity}, userId: ${_this.userId}, cancelSample: ${_this.cancelSample}, delaySample: ${_this.delaySample}, delay: ${_this.delay}, checkSample: ${_this.checkSample}, code: ${_this.code}, countryId: ${_this.countryId}, cityId: ${_this.cityId}, ordersCount: ${_this.ordersCount}, revenueEffective: ${_this.revenueEffective})';
}


}

/// @nodoc
abstract mixin class $BnbCopyWith<$Res>  {
  factory $BnbCopyWith(Bnb value, $Res Function(Bnb) _then) = _$BnbCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "bnbName") String? bnbName,@JsonKey(name: "deposit") int? deposit,@JsonKey(name: "depositPeriod") int? depositPeriod,@JsonKey(name: "orderSample") dynamic orderSample,@JsonKey(name: "activity") int? activity,@JsonKey(name: "userId") int? userId,@JsonKey(name: "cancelSample") String? cancelSample,@JsonKey(name: "delaySample") String? delaySample,@JsonKey(name: "delay") int? delay,@JsonKey(name: "checkSample") dynamic checkSample,@JsonKey(name: "code") String? code,@JsonKey(name: "countryId") int? countryId,@JsonKey(name: "cityId") int? cityId,@JsonKey(name: "orders_count") int ordersCount,@JsonKey(name: "revenue_effective") int? revenueEffective
});




}
/// @nodoc
class _$BnbCopyWithImpl<$Res>
    implements $BnbCopyWith<$Res> {
  _$BnbCopyWithImpl(this._self, this._then);

  final Bnb _self;
  final $Res Function(Bnb) _then;

/// Create a copy of Bnb
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? bnbName = freezed,Object? deposit = freezed,Object? depositPeriod = freezed,Object? orderSample = freezed,Object? activity = freezed,Object? userId = freezed,Object? cancelSample = freezed,Object? delaySample = freezed,Object? delay = freezed,Object? checkSample = freezed,Object? code = freezed,Object? countryId = freezed,Object? cityId = freezed,Object? ordersCount = null,Object? revenueEffective = freezed,}) {
  return _then(Bnb(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bnbName: freezed == bnbName ? _self.bnbName : bnbName // ignore: cast_nullable_to_non_nullable
as String?,deposit: freezed == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as int?,depositPeriod: freezed == depositPeriod ? _self.depositPeriod : depositPeriod // ignore: cast_nullable_to_non_nullable
as int?,orderSample: freezed == orderSample ? _self.orderSample : orderSample // ignore: cast_nullable_to_non_nullable
as dynamic,activity: freezed == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,cancelSample: freezed == cancelSample ? _self.cancelSample : cancelSample // ignore: cast_nullable_to_non_nullable
as String?,delaySample: freezed == delaySample ? _self.delaySample : delaySample // ignore: cast_nullable_to_non_nullable
as String?,delay: freezed == delay ? _self.delay : delay // ignore: cast_nullable_to_non_nullable
as int?,checkSample: freezed == checkSample ? _self.checkSample : checkSample // ignore: cast_nullable_to_non_nullable
as dynamic,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,ordersCount: null == ordersCount ? _self.ordersCount : ordersCount // ignore: cast_nullable_to_non_nullable
as int,revenueEffective: freezed == revenueEffective ? _self.revenueEffective : revenueEffective // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bnb].
extension BnbPatterns on Bnb {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bnb value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bnb() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bnb value)  $default,){
final _that = this;
switch (_that) {
case _Bnb():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bnb value)?  $default,){
final _that = this;
switch (_that) {
case _Bnb() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "bnbName")  String? bnbName, @JsonKey(name: "deposit")  int? deposit, @JsonKey(name: "depositPeriod")  int? depositPeriod, @JsonKey(name: "orderSample")  dynamic orderSample, @JsonKey(name: "activity")  int? activity, @JsonKey(name: "userId")  int? userId, @JsonKey(name: "cancelSample")  String? cancelSample, @JsonKey(name: "delaySample")  String? delaySample, @JsonKey(name: "delay")  int? delay, @JsonKey(name: "checkSample")  dynamic checkSample, @JsonKey(name: "code")  String? code, @JsonKey(name: "countryId")  int? countryId, @JsonKey(name: "cityId")  int? cityId, @JsonKey(name: "orders_count")  int ordersCount, @JsonKey(name: "revenue_effective")  int? revenueEffective)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bnb() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.bnbName,_that.deposit,_that.depositPeriod,_that.orderSample,_that.activity,_that.userId,_that.cancelSample,_that.delaySample,_that.delay,_that.checkSample,_that.code,_that.countryId,_that.cityId,_that.ordersCount,_that.revenueEffective);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "bnbName")  String? bnbName, @JsonKey(name: "deposit")  int? deposit, @JsonKey(name: "depositPeriod")  int? depositPeriod, @JsonKey(name: "orderSample")  dynamic orderSample, @JsonKey(name: "activity")  int? activity, @JsonKey(name: "userId")  int? userId, @JsonKey(name: "cancelSample")  String? cancelSample, @JsonKey(name: "delaySample")  String? delaySample, @JsonKey(name: "delay")  int? delay, @JsonKey(name: "checkSample")  dynamic checkSample, @JsonKey(name: "code")  String? code, @JsonKey(name: "countryId")  int? countryId, @JsonKey(name: "cityId")  int? cityId, @JsonKey(name: "orders_count")  int ordersCount, @JsonKey(name: "revenue_effective")  int? revenueEffective)  $default,) {final _that = this;
switch (_that) {
case _Bnb():
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.bnbName,_that.deposit,_that.depositPeriod,_that.orderSample,_that.activity,_that.userId,_that.cancelSample,_that.delaySample,_that.delay,_that.checkSample,_that.code,_that.countryId,_that.cityId,_that.ordersCount,_that.revenueEffective);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "bnbName")  String? bnbName, @JsonKey(name: "deposit")  int? deposit, @JsonKey(name: "depositPeriod")  int? depositPeriod, @JsonKey(name: "orderSample")  dynamic orderSample, @JsonKey(name: "activity")  int? activity, @JsonKey(name: "userId")  int? userId, @JsonKey(name: "cancelSample")  String? cancelSample, @JsonKey(name: "delaySample")  String? delaySample, @JsonKey(name: "delay")  int? delay, @JsonKey(name: "checkSample")  dynamic checkSample, @JsonKey(name: "code")  String? code, @JsonKey(name: "countryId")  int? countryId, @JsonKey(name: "cityId")  int? cityId, @JsonKey(name: "orders_count")  int ordersCount, @JsonKey(name: "revenue_effective")  int? revenueEffective)?  $default,) {final _that = this;
switch (_that) {
case _Bnb() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.bnbName,_that.deposit,_that.depositPeriod,_that.orderSample,_that.activity,_that.userId,_that.cancelSample,_that.delaySample,_that.delay,_that.checkSample,_that.code,_that.countryId,_that.cityId,_that.ordersCount,_that.revenueEffective);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bnb implements Bnb {
  const _Bnb({@JsonKey(name: "id") this.id, @JsonKey(name: "created_at") this.createdAt, @JsonKey(name: "updated_at") this.updatedAt, @JsonKey(name: "bnbName") this.bnbName, @JsonKey(name: "deposit") this.deposit, @JsonKey(name: "depositPeriod") this.depositPeriod, @JsonKey(name: "orderSample") this.orderSample, @JsonKey(name: "activity") this.activity, @JsonKey(name: "userId") this.userId, @JsonKey(name: "cancelSample") this.cancelSample, @JsonKey(name: "delaySample") this.delaySample, @JsonKey(name: "delay") this.delay, @JsonKey(name: "checkSample") this.checkSample, @JsonKey(name: "code") this.code, @JsonKey(name: "countryId") this.countryId, @JsonKey(name: "cityId") this.cityId, @JsonKey(name: "orders_count") this.ordersCount = 0, @JsonKey(name: "revenue_effective") this.revenueEffective});
  factory _Bnb.fromJson(Map<String, dynamic> json) => _$BnbFromJson(json);

@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "created_at") final  DateTime? createdAt;
@override@JsonKey(name: "updated_at") final  DateTime? updatedAt;
@override@JsonKey(name: "bnbName") final  String? bnbName;
@override@JsonKey(name: "deposit") final  int? deposit;
@override@JsonKey(name: "depositPeriod") final  int? depositPeriod;
@override@JsonKey(name: "orderSample") final  dynamic orderSample;
@override@JsonKey(name: "activity") final  int? activity;
@override@JsonKey(name: "userId") final  int? userId;
@override@JsonKey(name: "cancelSample") final  String? cancelSample;
@override@JsonKey(name: "delaySample") final  String? delaySample;
@override@JsonKey(name: "delay") final  int? delay;
@override@JsonKey(name: "checkSample") final  dynamic checkSample;
@override@JsonKey(name: "code") final  String? code;
@override@JsonKey(name: "countryId") final  int? countryId;
@override@JsonKey(name: "cityId") final  int? cityId;
@override@JsonKey(name: "orders_count") final  int ordersCount;
@override@JsonKey(name: "revenue_effective") final  int? revenueEffective;

/// Create a copy of Bnb
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BnbCopyWith<_Bnb> get copyWith => __$BnbCopyWithImpl<_Bnb>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BnbToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bnb&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bnbName, bnbName) || other.bnbName == bnbName)&&(identical(other.deposit, deposit) || other.deposit == deposit)&&(identical(other.depositPeriod, depositPeriod) || other.depositPeriod == depositPeriod)&&const DeepCollectionEquality().equals(other.orderSample, orderSample)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.cancelSample, cancelSample) || other.cancelSample == cancelSample)&&(identical(other.delaySample, delaySample) || other.delaySample == delaySample)&&(identical(other.delay, delay) || other.delay == delay)&&const DeepCollectionEquality().equals(other.checkSample, checkSample)&&(identical(other.code, code) || other.code == code)&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.ordersCount, ordersCount) || other.ordersCount == ordersCount)&&(identical(other.revenueEffective, revenueEffective) || other.revenueEffective == revenueEffective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,updatedAt,bnbName,deposit,depositPeriod,const DeepCollectionEquality().hash(orderSample),activity,userId,cancelSample,delaySample,delay,const DeepCollectionEquality().hash(checkSample),code,countryId,cityId,ordersCount,revenueEffective);
}

@override
String toString() {
    return 'Bnb(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bnbName: $bnbName, deposit: $deposit, depositPeriod: $depositPeriod, orderSample: $orderSample, activity: $activity, userId: $userId, cancelSample: $cancelSample, delaySample: $delaySample, delay: $delay, checkSample: $checkSample, code: $code, countryId: $countryId, cityId: $cityId, ordersCount: $ordersCount, revenueEffective: $revenueEffective)';
}


}

/// @nodoc
abstract mixin class _$BnbCopyWith<$Res> implements $BnbCopyWith<$Res> {
  factory _$BnbCopyWith(_Bnb value, $Res Function(_Bnb) _then) = __$BnbCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "bnbName") String? bnbName,@JsonKey(name: "deposit") int? deposit,@JsonKey(name: "depositPeriod") int? depositPeriod,@JsonKey(name: "orderSample") dynamic orderSample,@JsonKey(name: "activity") int? activity,@JsonKey(name: "userId") int? userId,@JsonKey(name: "cancelSample") String? cancelSample,@JsonKey(name: "delaySample") String? delaySample,@JsonKey(name: "delay") int? delay,@JsonKey(name: "checkSample") dynamic checkSample,@JsonKey(name: "code") String? code,@JsonKey(name: "countryId") int? countryId,@JsonKey(name: "cityId") int? cityId,@JsonKey(name: "orders_count") int ordersCount,@JsonKey(name: "revenue_effective") int? revenueEffective
});




}
/// @nodoc
class __$BnbCopyWithImpl<$Res>
    implements _$BnbCopyWith<$Res> {
  __$BnbCopyWithImpl(this._self, this._then);

  final _Bnb _self;
  final $Res Function(_Bnb) _then;

/// Create a copy of Bnb
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? bnbName = freezed,Object? deposit = freezed,Object? depositPeriod = freezed,Object? orderSample = freezed,Object? activity = freezed,Object? userId = freezed,Object? cancelSample = freezed,Object? delaySample = freezed,Object? delay = freezed,Object? checkSample = freezed,Object? code = freezed,Object? countryId = freezed,Object? cityId = freezed,Object? ordersCount = null,Object? revenueEffective = freezed,}) {
  return _then(_Bnb(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bnbName: freezed == bnbName ? _self.bnbName : bnbName // ignore: cast_nullable_to_non_nullable
as String?,deposit: freezed == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as int?,depositPeriod: freezed == depositPeriod ? _self.depositPeriod : depositPeriod // ignore: cast_nullable_to_non_nullable
as int?,orderSample: freezed == orderSample ? _self.orderSample : orderSample // ignore: cast_nullable_to_non_nullable
as dynamic,activity: freezed == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,cancelSample: freezed == cancelSample ? _self.cancelSample : cancelSample // ignore: cast_nullable_to_non_nullable
as String?,delaySample: freezed == delaySample ? _self.delaySample : delaySample // ignore: cast_nullable_to_non_nullable
as String?,delay: freezed == delay ? _self.delay : delay // ignore: cast_nullable_to_non_nullable
as int?,checkSample: freezed == checkSample ? _self.checkSample : checkSample // ignore: cast_nullable_to_non_nullable
as dynamic,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,ordersCount: null == ordersCount ? _self.ordersCount : ordersCount // ignore: cast_nullable_to_non_nullable
as int,revenueEffective: freezed == revenueEffective ? _self.revenueEffective : revenueEffective // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
