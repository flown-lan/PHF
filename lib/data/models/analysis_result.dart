/// # Analysis Result Entity
///
/// ## Description
/// 存储 SLM (Small Language Model) 对病历数据的结构化分析结果。
///
/// ## Fields
/// - `id`: 唯一标识 (UUID).
/// - `recordId`: 关联的 Record ID.
/// - `rawJson`: 模型输出的完整 JSON 结构 (含 classification, anomalies 等).
/// - `summary`: 自然语言摘要.
/// - `createdAt`: 分析生成时间.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

@freezed
abstract class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    required String id,
    required String recordId,
    required String rawJson,
    String? summary,
    required DateTime createdAt,
  }) = _AnalysisResult;

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}
