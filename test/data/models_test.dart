import 'package:flutter_test/flutter_test.dart';
import 'package:phf/data/models/person.dart';
import 'package:phf/data/models/tag.dart';
import 'package:phf/data/models/image.dart';
import 'package:phf/data/models/record.dart';

void main() {
  group('Entity Sanity Tests', () {
    test('Person serialization and defaults', () {
      final now = DateTime.now();
      final person = Person(
        id: 'p1',
        nickname: 'Me',
        isDefault: true,
        createdAt: now,
      );

      final json = person.toJson();
      expect(json['id'], 'p1');
      expect(json['nickname'], 'Me');
      expect(json['isDefault'], true);
      
      final fromJson = Person.fromJson(json);
      expect(fromJson, person);
    });

    test('Tag serialization', () {
      final tag = Tag(
        id: 't1',
        name: 'Report',
        color: '#FF0000',
        createdAt: DateTime.now(),
      );

      final json = tag.toJson();
      expect(json['name'], 'Report');
      expect(Tag.fromJson(json), tag);
    });

    test('MedicalImage encryptionKey and order', () {
      final image = MedicalImage(
        id: 'i1',
        recordId: 'r1',
        encryptionKey: 'base64_key',
        filePath: 'path/to/file',
        thumbnailPath: 'path/to/thumb',
        width: 100,
        height: 100,
      );

      expect(image.displayOrder, 0); // Default value
      final json = image.toJson();
      expect(json['encryptionKey'], 'base64_key');
      expect(MedicalImage.fromJson(json), image);
    });

    test('MedicalRecord status and tagsCache', () {
      final record = MedicalRecord(
        id: 'r1',
        title: 'Checkup',
        notedAt: DateTime(2023, 1, 1),
        createdAt: DateTime.now(),
      );

      expect(record.status, RecordStatus.archived); // Default value
      final json = record.toJson();
      expect(json['status'], 'archived');
      expect(MedicalRecord.fromJson(json).title, 'Checkup');
    });
  });
}
