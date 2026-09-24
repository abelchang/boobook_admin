// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Solar {

@JsonKey(name: "id") int? get id;@JsonKey(name: "date") DateTime get date;@JsonKey(name: "name") String get name;@JsonKey(name: "description") String? get description;@JsonKey(name: "generated_at") DateTime? get generatedAt;
/// Create a copy of Solar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolarCopyWith<Solar> get copyWith => _$SolarCopyWithImpl<Solar>(this as Solar, _$identity);

  /// Serializes this Solar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Solar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Solar&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Solar;
  return Object.hash(runtimeType,_this.id,_this.date,_this.name,_this.description,_this.generatedAt);
}

@override
String toString() {
  final _this = this as Solar;
  return 'Solar(id: ${_this.id}, date: ${_this.date}, name: ${_this.name}, description: ${_this.description}, generatedAt: ${_this.generatedAt})';
}


}

/// @nodoc
abstract mixin class $SolarCopyWith<$Res>  {
  factory $SolarCopyWith(Solar value, $Res Function(Solar) _then) = _$SolarCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "date") DateTime date,@JsonKey(name: "name") String name,@JsonKey(name: "description") String? description,@JsonKey(name: "generated_at") DateTime? generatedAt
});




}
/// @nodoc
class _$SolarCopyWithImpl<$Res>
    implements $SolarCopyWith<$Res> {
  _$SolarCopyWithImpl(this._self, this._then);

  final Solar _self;
  final $Res Function(Solar) _then;

/// Create a copy of Solar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = null,Object? name = null,Object? description = freezed,Object? generatedAt = freezed,}) {
  return _then(Solar(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Solar].
extension SolarPatterns on Solar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Solar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Solar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Solar value)  $default,){
final _that = this;
switch (_that) {
case _Solar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Solar value)?  $default,){
final _that = this;
switch (_that) {
case _Solar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "description")  String? description, @JsonKey(name: "generated_at")  DateTime? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Solar() when $default != null:
return $default(_that.id,_that.date,_that.name,_that.description,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "description")  String? description, @JsonKey(name: "generated_at")  DateTime? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _Solar():
return $default(_that.id,_that.date,_that.name,_that.description,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "id")  int? id, @JsonKey(name: "date")  DateTime date, @JsonKey(name: "name")  String name, @JsonKey(name: "description")  String? description, @JsonKey(name: "generated_at")  DateTime? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Solar() when $default != null:
return $default(_that.id,_that.date,_that.name,_that.description,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Solar implements Solar {
  const _Solar({@JsonKey(name: "id") this.id, @JsonKey(name: "date") required this.date, @JsonKey(name: "name") required this.name, @JsonKey(name: "description") this.description, @JsonKey(name: "generated_at") this.generatedAt});
  factory _Solar.fromJson(Map<String, dynamic> json) => _$SolarFromJson(json);

@override@JsonKey(name: "id") final  int? id;
@override@JsonKey(name: "date") final  DateTime date;
@override@JsonKey(name: "name") final  String name;
@override@JsonKey(name: "description") final  String? description;
@override@JsonKey(name: "generated_at") final  DateTime? generatedAt;

/// Create a copy of Solar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolarCopyWith<_Solar> get copyWith => __$SolarCopyWithImpl<_Solar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SolarToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Solar&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,date,name,description,generatedAt);
}

@override
String toString() {
    return 'Solar(id: $id, date: $date, name: $name, description: $description, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$SolarCopyWith<$Res> implements $SolarCopyWith<$Res> {
  factory _$SolarCopyWith(_Solar value, $Res Function(_Solar) _then) = __$SolarCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "id") int? id,@JsonKey(name: "date") DateTime date,@JsonKey(name: "name") String name,@JsonKey(name: "description") String? description,@JsonKey(name: "generated_at") DateTime? generatedAt
});




}
/// @nodoc
class __$SolarCopyWithImpl<$Res>
    implements _$SolarCopyWith<$Res> {
  __$SolarCopyWithImpl(this._self, this._then);

  final _Solar _self;
  final $Res Function(_Solar) _then;

/// Create a copy of Solar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = null,Object? name = null,Object? description = freezed,Object? generatedAt = freezed,}) {
  return _then(_Solar(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
