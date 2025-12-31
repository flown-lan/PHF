// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OCRBlockImpl _$$OCRBlockImplFromJson(Map<String, dynamic> json) =>
    _$OCRBlockImpl(
      text: json['text'] as String,
      left: (json['left'] as num).toDouble(),
      top: (json['top'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$$OCRBlockImplToJson(_$OCRBlockImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'left': instance.left,
      'top': instance.top,
      'width': instance.width,
      'height': instance.height,
    };

_$OCRResultImpl _$$OCRResultImplFromJson(Map<String, dynamic> json) =>
    _$OCRResultImpl(
      text: json['text'] as String,
      blocks: (json['blocks'] as List<dynamic>?)
              ?.map((e) => OCRBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$OCRResultImplToJson(_$OCRResultImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'blocks': instance.blocks,
      'confidence': instance.confidence,
    };
