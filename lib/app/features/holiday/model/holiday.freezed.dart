// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Holiday {

@JsonKey(name: "id") int? get id;@JsonKey(name: "created_at") DateTime? get createdAt;@JsonKey(name: "updated_at") DateTime? get updatedAt;@JsonKey(name: "date") DateTime get date;@JsonKey(name: "name") String get name;@JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt) bool get isHoliday;@JsonKey(name: "holidayCategory") String? get holidayCategory;@JsonKey(name: "description") String? get description;@JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt) bool get tep;
/// Create a copy of Holiday
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayCopyWith<Holiday> get copyWith => _$HolidayCopyWithImpl<Holiday>(this as Holiday, _$identity);

  /// Serializes this Holiday to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Holiday;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Holiday&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.isHoliday, _this.isHoliday) || other.isHoliday == _this.isHoliday)&&(identical(other.holidayCategory, _this.holidayCategory) || other.holidayCategory == _this.holidayCategory)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.tep, _this.tep) || other.tep == _this.tep));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Holiday;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.updatedAt,_this.date,_this.name,_this.isHoliday,_this.holidayCategory,_this.description,_this.tep);
}

@override
String toString() {
  final _this = this as Holiday;
  return 'Holiday(id: ${_this.id}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, date: ${_this.date}, name: ${_this.name}, isHoliday: ${_this.isHoliday}, holidayCategory: ${_this.holidayCategory}, description: ${_this.description}, tep: ${_this.tep})';
}


}

/// @nodoc
abstract mixin class $HolidayCopyWith<$Res>  {
  factory $HolidayCopyWith(Holiday value, $Res Function(Holiday) _then) = _$HolidayCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "date") DateTime date,@JsonKey(name: "name") String name,@JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt) bool isHoliday,@JsonKey(name: "holidayCategory") String? holidayCategory,@JsonKey(name: "description") String? description,@JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt) bool tep
});




}
/// @nodoc
class _$HolidayCopyWithImpl<$Res>
    implements $HolidayCopyWith<$Res> {
  _$HolidayCopyWithImpl(this._self, this._then);

  final Holiday _self;
  final $Res Function(Holiday) _then;

/// Create a copy of Holiday
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? date = null,Object? name = null,Object? isHoliday = null,Object? holidayCategory = freezed,Object? description = freezed,Object? tep = null,}) {
  return _then(Holiday(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,holidayCategory: freezed == holidayCategory ? _self.holidayCategory : holidayCategory // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tep: null == tep ? _self.tep : tep // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Holiday].
extension HolidayPatterns on Holiday {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Holiday value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Holiday() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Holiday value)  $default,){
final _that = this;
switch (_that) {
case _Holiday():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Holiday value)?  $default,){
final _that = this;
switch (_that) {
case _Holiday() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)  bool isHoliday, @JsonKey(name: "holidayCategory")  String? holidayCategory, @JsonKey(name: "description")  String? description, @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)  bool tep)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Holiday() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.date,_that.name,_that.isHoliday,_that.holidayCategory,_that.description,_that.tep);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)  bool isHoliday, @JsonKey(name: "holidayCategory")  String? holidayCategory, @JsonKey(name: "description")  String? description, @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)  bool tep)  $default,) {final _that = this;
switch (_that) {
case _Holiday():
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.date,_that.name,_that.isHoliday,_that.holidayCategory,_that.description,_that.tep);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "created_at")  DateTime? createdAt, @JsonKey(name: "updated_at")  DateTime? updatedAt, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)  bool isHoliday, @JsonKey(name: "holidayCategory")  String? holidayCategory, @JsonKey(name: "description")  String? description, @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)  bool tep)?  $default,) {final _that = this;
switch (_that) {
case _Holiday() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.date,_that.name,_that.isHoliday,_that.holidayCategory,_that.description,_that.tep);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Holiday implements Holiday {
  const _Holiday({@JsonKey(name: "id") this.id, @JsonKey(name: "created_at") this.createdAt, @JsonKey(name: "updated_at") this.updatedAt, @JsonKey(name: "date") required this.date, @JsonKey(name: "name") required this.name, @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt) required this.isHoliday, @JsonKey(name: "holidayCategory") this.holidayCategory, @JsonKey(name: "description") this.description, @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt) this.tep = false});
  factory _Holiday.fromJson(Map<String, dynamic> json) => _$HolidayFromJson(json);

@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "created_at") final  DateTime? createdAt;
@override@JsonKey(name: "updated_at") final  DateTime? updatedAt;
@override@JsonKey(name: "date") final  DateTime date;
@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt) final  bool isHoliday;
@override@JsonKey(name: "holidayCategory") final  String? holidayCategory;
@override@JsonKey(name: "description") final  String? description;
@override@JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt) final  bool tep;

/// Create a copy of Holiday
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayCopyWith<_Holiday> get copyWith => __$HolidayCopyWithImpl<_Holiday>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Holiday&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.holidayCategory, holidayCategory) || other.holidayCategory == holidayCategory)&&(identical(other.description, description) || other.description == description)&&(identical(other.tep, tep) || other.tep == tep));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,updatedAt,date,name,isHoliday,holidayCategory,description,tep);
}

@override
String toString() {
    return 'Holiday(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, date: $date, name: $name, isHoliday: $isHoliday, holidayCategory: $holidayCategory, description: $description, tep: $tep)';
}


}

/// @nodoc
abstract mixin class _$HolidayCopyWith<$Res> implements $HolidayCopyWith<$Res> {
  factory _$HolidayCopyWith(_Holiday value, $Res Function(_Holiday) _then) = __$HolidayCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "created_at") DateTime? createdAt,@JsonKey(name: "updated_at") DateTime? updatedAt,@JsonKey(name: "date") DateTime date,@JsonKey(name: "name") String name,@JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt) bool isHoliday,@JsonKey(name: "holidayCategory") String? holidayCategory,@JsonKey(name: "description") String? description,@JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt) bool tep
});




}
/// @nodoc
class __$HolidayCopyWithImpl<$Res>
    implements _$HolidayCopyWith<$Res> {
  __$HolidayCopyWithImpl(this._self, this._then);

  final _Holiday _self;
  final $Res Function(_Holiday) _then;

/// Create a copy of Holiday
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? date = null,Object? name = null,Object? isHoliday = null,Object? holidayCategory = freezed,Object? description = freezed,Object? tep = null,}) {
  return _then(_Holiday(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,holidayCategory: freezed == holidayCategory ? _self.holidayCategory : holidayCategory // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tep: null == tep ? _self.tep : tep // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
