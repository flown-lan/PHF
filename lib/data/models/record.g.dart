// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalRecordImpl _$$MedicalRecordImplFromJson(Map<String, dynamic> json) =>
    _$MedicalRecordImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      notedAt: DateTime.parse(json['notedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecodeNullable(_$RecordStatusEnumMap, json['status']) ??
          RecordStatus.archived,
      tagsCache: json['tagsCache'] as String?,
    );

Map<String, dynamic> _$$MedicalRecordImplToJson(_$MedicalRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notedAt': instance.notedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$RecordStatusEnumMap[instance.status]!,
      'tagsCache': instance.tagsCache,
    };

const _$RecordStatusEnumMap = {
  RecordStatus.archived: 'archived',
  RecordStatus.deleted: 'deleted',
};
