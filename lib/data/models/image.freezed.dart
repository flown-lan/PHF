// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicalImage _$MedicalImageFromJson(Map<String, dynamic> json) {
  return _MedicalImage.fromJson(json);
}

/// @nodoc
mixin _$MedicalImage {
  String get id => throw _privateConstructorUsedError;
  String get recordId => throw _privateConstructorUsedError;
  String get encryptionKey => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String get thumbnailPath => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// 内存关联字段，不直接参与数据库简单序列化
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Tag> get tags => throw _privateConstructorUsedError;

  /// Serializes this MedicalImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalImageCopyWith<MedicalImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalImageCopyWith<$Res> {
  factory $MedicalImageCopyWith(
          MedicalImage value, $Res Function(MedicalImage) then) =
      _$MedicalImageCopyWithImpl<$Res, MedicalImage>;
  @useResult
  $Res call(
      {String id,
      String recordId,
      String encryptionKey,
      String filePath,
      String thumbnailPath,
      int displayOrder,
      int? width,
      int? height,
      @JsonKey(includeFromJson: false, includeToJson: false) List<Tag> tags});
}

/// @nodoc
class _$MedicalImageCopyWithImpl<$Res, $Val extends MedicalImage>
    implements $MedicalImageCopyWith<$Res> {
  _$MedicalImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordId = null,
    Object? encryptionKey = null,
    Object? filePath = null,
    Object? thumbnailPath = null,
    Object? displayOrder = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordId: null == recordId
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionKey: null == encryptionKey
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailPath: null == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicalImageImplCopyWith<$Res>
    implements $MedicalImageCopyWith<$Res> {
  factory _$$MedicalImageImplCopyWith(
          _$MedicalImageImpl value, $Res Function(_$MedicalImageImpl) then) =
      __$$MedicalImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String recordId,
      String encryptionKey,
      String filePath,
      String thumbnailPath,
      int displayOrder,
      int? width,
      int? height,
      @JsonKey(includeFromJson: false, includeToJson: false) List<Tag> tags});
}

/// @nodoc
class __$$MedicalImageImplCopyWithImpl<$Res>
    extends _$MedicalImageCopyWithImpl<$Res, _$MedicalImageImpl>
    implements _$$MedicalImageImplCopyWith<$Res> {
  __$$MedicalImageImplCopyWithImpl(
      _$MedicalImageImpl _value, $Res Function(_$MedicalImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicalImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recordId = null,
    Object? encryptionKey = null,
    Object? filePath = null,
    Object? thumbnailPath = null,
    Object? displayOrder = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? tags = null,
  }) {
    return _then(_$MedicalImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recordId: null == recordId
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as String,
      encryptionKey: null == encryptionKey
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailPath: null == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicalImageImpl implements _MedicalImage {
  const _$MedicalImageImpl(
      {required this.id,
      required this.recordId,
      required this.encryptionKey,
      required this.filePath,
      required this.thumbnailPath,
      this.displayOrder = 0,
      this.width,
      this.height,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<Tag> tags = const []})
      : _tags = tags;

  factory _$MedicalImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalImageImplFromJson(json);

  @override
  final String id;
  @override
  final String recordId;
  @override
  final String encryptionKey;
  @override
  final String filePath;
  @override
  final String thumbnailPath;
  @override
  @JsonKey()
  final int displayOrder;
  @override
  final int? width;
  @override
  final int? height;

  /// 内存关联字段，不直接参与数据库简单序列化
  final List<Tag> _tags;

  /// 内存关联字段，不直接参与数据库简单序列化
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'MedicalImage(id: $id, recordId: $recordId, encryptionKey: $encryptionKey, filePath: $filePath, thumbnailPath: $thumbnailPath, displayOrder: $displayOrder, width: $width, height: $height, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recordId, recordId) ||
                other.recordId == recordId) &&
            (identical(other.encryptionKey, encryptionKey) ||
                other.encryptionKey == encryptionKey) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recordId,
      encryptionKey,
      filePath,
      thumbnailPath,
      displayOrder,
      width,
      height,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of MedicalImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalImageImplCopyWith<_$MedicalImageImpl> get copyWith =>
      __$$MedicalImageImplCopyWithImpl<_$MedicalImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalImageImplToJson(
      this,
    );
  }
}

abstract class _MedicalImage implements MedicalImage {
  const factory _MedicalImage(
      {required final String id,
      required final String recordId,
      required final String encryptionKey,
      required final String filePath,
      required final String thumbnailPath,
      final int displayOrder,
      final int? width,
      final int? height,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<Tag> tags}) = _$MedicalImageImpl;

  factory _MedicalImage.fromJson(Map<String, dynamic> json) =
      _$MedicalImageImpl.fromJson;

  @override
  String get id;
  @override
  String get recordId;
  @override
  String get encryptionKey;
  @override
  String get filePath;
  @override
  String get thumbnailPath;
  @override
  int get displayOrder;
  @override
  int? get width;
  @override
  int? get height;

  /// 内存关联字段，不直接参与数据库简单序列化
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Tag> get tags;

  /// Create a copy of MedicalImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalImageImplCopyWith<_$MedicalImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
