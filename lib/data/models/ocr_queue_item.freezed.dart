// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_queue_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OCRQueueItem _$OCRQueueItemFromJson(Map<String, dynamic> json) {
  return _OCRQueueItem.fromJson(json);
}

/// @nodoc
mixin _$OCRQueueItem {
  String get id => throw _privateConstructorUsedError;
  String get imageId => throw _privateConstructorUsedError;
  OCRJobStatus get status => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  String? get lastError => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OCRQueueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OCRQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OCRQueueItemCopyWith<OCRQueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OCRQueueItemCopyWith<$Res> {
  factory $OCRQueueItemCopyWith(
          OCRQueueItem value, $Res Function(OCRQueueItem) then) =
      _$OCRQueueItemCopyWithImpl<$Res, OCRQueueItem>;
  @useResult
  $Res call(
      {String id,
      String imageId,
      OCRJobStatus status,
      int retryCount,
      String? lastError,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$OCRQueueItemCopyWithImpl<$Res, $Val extends OCRQueueItem>
    implements $OCRQueueItemCopyWith<$Res> {
  _$OCRQueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OCRQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageId = null,
    Object? status = null,
    Object? retryCount = null,
    Object? lastError = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageId: null == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OCRJobStatus,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastError: freezed == lastError
          ? _value.lastError
          : lastError // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OCRQueueItemImplCopyWith<$Res>
    implements $OCRQueueItemCopyWith<$Res> {
  factory _$$OCRQueueItemImplCopyWith(
          _$OCRQueueItemImpl value, $Res Function(_$OCRQueueItemImpl) then) =
      __$$OCRQueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String imageId,
      OCRJobStatus status,
      int retryCount,
      String? lastError,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$OCRQueueItemImplCopyWithImpl<$Res>
    extends _$OCRQueueItemCopyWithImpl<$Res, _$OCRQueueItemImpl>
    implements _$$OCRQueueItemImplCopyWith<$Res> {
  __$$OCRQueueItemImplCopyWithImpl(
      _$OCRQueueItemImpl _value, $Res Function(_$OCRQueueItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OCRQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageId = null,
    Object? status = null,
    Object? retryCount = null,
    Object? lastError = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$OCRQueueItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageId: null == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OCRJobStatus,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastError: freezed == lastError
          ? _value.lastError
          : lastError // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OCRQueueItemImpl implements _OCRQueueItem {
  const _$OCRQueueItemImpl(
      {required this.id,
      required this.imageId,
      this.status = OCRJobStatus.pending,
      this.retryCount = 0,
      this.lastError,
      required this.createdAt,
      required this.updatedAt});

  factory _$OCRQueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OCRQueueItemImplFromJson(json);

  @override
  final String id;
  @override
  final String imageId;
  @override
  @JsonKey()
  final OCRJobStatus status;
  @override
  @JsonKey()
  final int retryCount;
  @override
  final String? lastError;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'OCRQueueItem(id: $id, imageId: $imageId, status: $status, retryCount: $retryCount, lastError: $lastError, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRQueueItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageId, imageId) || other.imageId == imageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageId, status, retryCount,
      lastError, createdAt, updatedAt);

  /// Create a copy of OCRQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRQueueItemImplCopyWith<_$OCRQueueItemImpl> get copyWith =>
      __$$OCRQueueItemImplCopyWithImpl<_$OCRQueueItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OCRQueueItemImplToJson(
      this,
    );
  }
}

abstract class _OCRQueueItem implements OCRQueueItem {
  const factory _OCRQueueItem(
      {required final String id,
      required final String imageId,
      final OCRJobStatus status,
      final int retryCount,
      final String? lastError,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$OCRQueueItemImpl;

  factory _OCRQueueItem.fromJson(Map<String, dynamic> json) =
      _$OCRQueueItemImpl.fromJson;

  @override
  String get id;
  @override
  String get imageId;
  @override
  OCRJobStatus get status;
  @override
  int get retryCount;
  @override
  String? get lastError;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of OCRQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OCRQueueItemImplCopyWith<_$OCRQueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
