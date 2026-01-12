// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnalysisResult _$AnalysisResultFromJson(Map<String, dynamic> json) =>
    _AnalysisResult(
      id: json['id'] as String,
      recordId: json['recordId'] as String,
      rawJson: json['rawJson'] as String,
      summary: json['summary'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AnalysisResultToJson(_AnalysisResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordId': instance.recordId,
      'rawJson': instance.rawJson,
      'summary': instance.summary,
      'createdAt': instance.createdAt.toIso8601String(),
    };
