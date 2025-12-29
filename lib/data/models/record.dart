/// # Record Entity
///
/// ## Description
/// 医疗事件记录（如：一次就诊、一份体检报告）。
///
/// ## Fields
/// - `id`: 唯一标识 (UUID).
/// - `title`: 标题或简述.
/// - `notedAt`: 事件发生时间.
/// - `createdAt`: 系统录入时间.
/// - `status`: 状态 (`archived`, `deleted`).
/// - `tagsCache`: 聚合标签的 JSON 缓存字串，用于 Timeline 快速渲染.
/// - `images`: 该记录包含的所有图片 (非数据库字段, 内存聚合).
///
/// ## Implementation Rules
/// - 符合 `Spec#Data Schema`：`status` 默认为 `archived`。
/// - 符合 `Constitution#II. Architecture`：作为 Domain Layer 的核心对象。

import 'package:freezed_annotation/freezed_annotation.dart';
import 'image.dart';

part 'record.freezed.dart';
part 'record.g.dart';

enum RecordStatus {
  @JsonValue('archived')
  archived,
  @JsonValue('deleted')
  deleted,
}

@freezed
class MedicalRecord with _$MedicalRecord {
  const factory MedicalRecord({
    required String id,
    required String title,
    required DateTime notedAt,
    required DateTime createdAt,
    @Default(RecordStatus.archived) RecordStatus status,
    String? tagsCache,
    
    /// 内存关联字段
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([]) List<MedicalImage> images,
  }) = _MedicalRecord;

  factory MedicalRecord.fromJson(Map<String, dynamic> json) => _$MedicalRecordFromJson(json);
}
