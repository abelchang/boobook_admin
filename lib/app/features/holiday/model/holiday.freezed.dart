// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Holiday _$HolidayFromJson(Map<String, dynamic> json) {
  return _Holiday.fromJson(json);
}

/// @nodoc
mixin _$Holiday {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
  bool get isHoliday => throw _privateConstructorUsedError;
  @JsonKey(name: "holidayCategory")
  String? get holidayCategory => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
  bool get tep => throw _privateConstructorUsedError;

  /// Serializes this Holiday to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidayCopyWith<Holiday> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayCopyWith<$Res> {
  factory $HolidayCopyWith(Holiday value, $Res Function(Holiday) then) =
      _$HolidayCopyWithImpl<$Res, Holiday>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "created_at") DateTime? createdAt,
      @JsonKey(name: "updated_at") DateTime? updatedAt,
      @JsonKey(name: "date") DateTime date,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
      bool isHoliday,
      @JsonKey(name: "holidayCategory") String? holidayCategory,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
      bool tep});
}

/// @nodoc
class _$HolidayCopyWithImpl<$Res, $Val extends Holiday>
    implements $HolidayCopyWith<$Res> {
  _$HolidayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? date = null,
    Object? name = null,
    Object? isHoliday = null,
    Object? holidayCategory = freezed,
    Object? description = freezed,
    Object? tep = null,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isHoliday: null == isHoliday
          ? _value.isHoliday
          : isHoliday // ignore: cast_nullable_to_non_nullable
              as bool,
      holidayCategory: freezed == holidayCategory
          ? _value.holidayCategory
          : holidayCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tep: null == tep
          ? _value.tep
          : tep // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HolidayImplCopyWith<$Res> implements $HolidayCopyWith<$Res> {
  factory _$$HolidayImplCopyWith(
          _$HolidayImpl value, $Res Function(_$HolidayImpl) then) =
      __$$HolidayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "created_at") DateTime? createdAt,
      @JsonKey(name: "updated_at") DateTime? updatedAt,
      @JsonKey(name: "date") DateTime date,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
      bool isHoliday,
      @JsonKey(name: "holidayCategory") String? holidayCategory,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
      bool tep});
}

/// @nodoc
class __$$HolidayImplCopyWithImpl<$Res>
    extends _$HolidayCopyWithImpl<$Res, _$HolidayImpl>
    implements _$$HolidayImplCopyWith<$Res> {
  __$$HolidayImplCopyWithImpl(
      _$HolidayImpl _value, $Res Function(_$HolidayImpl) _then)
      : super(_value, _then);

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? date = null,
    Object? name = null,
    Object? isHoliday = null,
    Object? holidayCategory = freezed,
    Object? description = freezed,
    Object? tep = null,
  }) {
    return _then(_$HolidayImpl(
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isHoliday: null == isHoliday
          ? _value.isHoliday
          : isHoliday // ignore: cast_nullable_to_non_nullable
              as bool,
      holidayCategory: freezed == holidayCategory
          ? _value.holidayCategory
          : holidayCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tep: null == tep
          ? _value.tep
          : tep // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidayImpl implements _Holiday {
  const _$HolidayImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "date") required this.date,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
      required this.isHoliday,
      @JsonKey(name: "holidayCategory") this.holidayCategory,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
      this.tep = false});

  factory _$HolidayImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayImplFromJson(json);

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
  @JsonKey(name: "date")
  final DateTime date;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
  final bool isHoliday;
  @override
  @JsonKey(name: "holidayCategory")
  final String? holidayCategory;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
  final bool tep;

  @override
  String toString() {
    return 'Holiday(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, date: $date, name: $name, isHoliday: $isHoliday, holidayCategory: $holidayCategory, description: $description, tep: $tep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isHoliday, isHoliday) ||
                other.isHoliday == isHoliday) &&
            (identical(other.holidayCategory, holidayCategory) ||
                other.holidayCategory == holidayCategory) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.tep, tep) || other.tep == tep));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt, date,
      name, isHoliday, holidayCategory, description, tep);

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      __$$HolidayImplCopyWithImpl<_$HolidayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayImplToJson(
      this,
    );
  }
}

abstract class _Holiday implements Holiday {
  const factory _Holiday(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "created_at") final DateTime? createdAt,
      @JsonKey(name: "updated_at") final DateTime? updatedAt,
      @JsonKey(name: "date") required final DateTime date,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
      required final bool isHoliday,
      @JsonKey(name: "holidayCategory") final String? holidayCategory,
      @JsonKey(name: "description") final String? description,
      @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
      final bool tep}) = _$HolidayImpl;

  factory _Holiday.fromJson(Map<String, dynamic> json) = _$HolidayImpl.fromJson;

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
  @JsonKey(name: "date")
  DateTime get date;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "isHoliday", fromJson: boolFromInt, toJson: boolToInt)
  bool get isHoliday;
  @override
  @JsonKey(name: "holidayCategory")
  String? get holidayCategory;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(name: "tep", fromJson: boolFromInt, toJson: boolToInt)
  bool get tep;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
