// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OCRBlock _$OCRBlockFromJson(Map<String, dynamic> json) {
  return _OCRBlock.fromJson(json);
}

/// @nodoc
mixin _$OCRBlock {
  String get text => throw _privateConstructorUsedError;
  double get left => throw _privateConstructorUsedError;
  double get top => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;

  /// Serializes this OCRBlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OCRBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OCRBlockCopyWith<OCRBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OCRBlockCopyWith<$Res> {
  factory $OCRBlockCopyWith(OCRBlock value, $Res Function(OCRBlock) then) =
      _$OCRBlockCopyWithImpl<$Res, OCRBlock>;
  @useResult
  $Res call(
      {String text, double left, double top, double width, double height});
}

/// @nodoc
class _$OCRBlockCopyWithImpl<$Res, $Val extends OCRBlock>
    implements $OCRBlockCopyWith<$Res> {
  _$OCRBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OCRBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? left = null,
    Object? top = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as double,
      top: null == top
          ? _value.top
          : top // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OCRBlockImplCopyWith<$Res>
    implements $OCRBlockCopyWith<$Res> {
  factory _$$OCRBlockImplCopyWith(
          _$OCRBlockImpl value, $Res Function(_$OCRBlockImpl) then) =
      __$$OCRBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text, double left, double top, double width, double height});
}

/// @nodoc
class __$$OCRBlockImplCopyWithImpl<$Res>
    extends _$OCRBlockCopyWithImpl<$Res, _$OCRBlockImpl>
    implements _$$OCRBlockImplCopyWith<$Res> {
  __$$OCRBlockImplCopyWithImpl(
      _$OCRBlockImpl _value, $Res Function(_$OCRBlockImpl) _then)
      : super(_value, _then);

  /// Create a copy of OCRBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? left = null,
    Object? top = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$OCRBlockImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as double,
      top: null == top
          ? _value.top
          : top // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OCRBlockImpl implements _OCRBlock {
  const _$OCRBlockImpl(
      {required this.text,
      required this.left,
      required this.top,
      required this.width,
      required this.height});

  factory _$OCRBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$OCRBlockImplFromJson(json);

  @override
  final String text;
  @override
  final double left;
  @override
  final double top;
  @override
  final double width;
  @override
  final double height;

  @override
  String toString() {
    return 'OCRBlock(text: $text, left: $left, top: $top, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRBlockImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, left, top, width, height);

  /// Create a copy of OCRBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRBlockImplCopyWith<_$OCRBlockImpl> get copyWith =>
      __$$OCRBlockImplCopyWithImpl<_$OCRBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OCRBlockImplToJson(
      this,
    );
  }
}

abstract class _OCRBlock implements OCRBlock {
  const factory _OCRBlock(
      {required final String text,
      required final double left,
      required final double top,
      required final double width,
      required final double height}) = _$OCRBlockImpl;

  factory _OCRBlock.fromJson(Map<String, dynamic> json) =
      _$OCRBlockImpl.fromJson;

  @override
  String get text;
  @override
  double get left;
  @override
  double get top;
  @override
  double get width;
  @override
  double get height;

  /// Create a copy of OCRBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OCRBlockImplCopyWith<_$OCRBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OCRResult _$OCRResultFromJson(Map<String, dynamic> json) {
  return _OCRResult.fromJson(json);
}

/// @nodoc
mixin _$OCRResult {
  String get text => throw _privateConstructorUsedError;
  List<OCRBlock> get blocks => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  /// Serializes this OCRResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OCRResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OCRResultCopyWith<OCRResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OCRResultCopyWith<$Res> {
  factory $OCRResultCopyWith(OCRResult value, $Res Function(OCRResult) then) =
      _$OCRResultCopyWithImpl<$Res, OCRResult>;
  @useResult
  $Res call({String text, List<OCRBlock> blocks, double confidence});
}

/// @nodoc
class _$OCRResultCopyWithImpl<$Res, $Val extends OCRResult>
    implements $OCRResultCopyWith<$Res> {
  _$OCRResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OCRResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? blocks = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<OCRBlock>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OCRResultImplCopyWith<$Res>
    implements $OCRResultCopyWith<$Res> {
  factory _$$OCRResultImplCopyWith(
          _$OCRResultImpl value, $Res Function(_$OCRResultImpl) then) =
      __$$OCRResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<OCRBlock> blocks, double confidence});
}

/// @nodoc
class __$$OCRResultImplCopyWithImpl<$Res>
    extends _$OCRResultCopyWithImpl<$Res, _$OCRResultImpl>
    implements _$$OCRResultImplCopyWith<$Res> {
  __$$OCRResultImplCopyWithImpl(
      _$OCRResultImpl _value, $Res Function(_$OCRResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of OCRResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? blocks = null,
    Object? confidence = null,
  }) {
    return _then(_$OCRResultImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      blocks: null == blocks
          ? _value._blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<OCRBlock>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OCRResultImpl implements _OCRResult {
  const _$OCRResultImpl(
      {required this.text,
      final List<OCRBlock> blocks = const [],
      this.confidence = 0.0})
      : _blocks = blocks;

  factory _$OCRResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OCRResultImplFromJson(json);

  @override
  final String text;
  final List<OCRBlock> _blocks;
  @override
  @JsonKey()
  List<OCRBlock> get blocks {
    if (_blocks is EqualUnmodifiableListView) return _blocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocks);
  }

  @override
  @JsonKey()
  final double confidence;

  @override
  String toString() {
    return 'OCRResult(text: $text, blocks: $blocks, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRResultImpl &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._blocks, _blocks) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text,
      const DeepCollectionEquality().hash(_blocks), confidence);

  /// Create a copy of OCRResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRResultImplCopyWith<_$OCRResultImpl> get copyWith =>
      __$$OCRResultImplCopyWithImpl<_$OCRResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OCRResultImplToJson(
      this,
    );
  }
}

abstract class _OCRResult implements OCRResult {
  const factory _OCRResult(
      {required final String text,
      final List<OCRBlock> blocks,
      final double confidence}) = _$OCRResultImpl;

  factory _OCRResult.fromJson(Map<String, dynamic> json) =
      _$OCRResultImpl.fromJson;

  @override
  String get text;
  @override
  List<OCRBlock> get blocks;
  @override
  double get confidence;

  /// Create a copy of OCRResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OCRResultImplCopyWith<_$OCRResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
