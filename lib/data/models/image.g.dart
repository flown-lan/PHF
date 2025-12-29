// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalImageImpl _$$MedicalImageImplFromJson(Map<String, dynamic> json) =>
    _$MedicalImageImpl(
      id: json['id'] as String,
      recordId: json['recordId'] as String,
      encryptionKey: json['encryptionKey'] as String,
      filePath: json['filePath'] as String,
      thumbnailPath: json['thumbnailPath'] as String,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MedicalImageImplToJson(_$MedicalImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordId': instance.recordId,
      'encryptionKey': instance.encryptionKey,
      'filePath': instance.filePath,
      'thumbnailPath': instance.thumbnailPath,
      'displayOrder': instance.displayOrder,
      'width': instance.width,
      'height': instance.height,
    };
