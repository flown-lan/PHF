import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:phf/data/repositories/search_repository.dart';
import 'package:phf/data/datasources/local/database_service.dart';
import 'package:phf/core/security/master_key_manager.dart';
import 'package:phf/core/services/path_provider_service.dart';

// Mock Classes
class MockMasterKeyManager extends Mock implements MasterKeyManager {
  @override
  Future<Uint8List> getMasterKey() async => Uint8List(32);
}

class MockPathProviderService extends Mock implements PathProviderService {
  final String path;
  MockPathProviderService(this.path);
  @override
  String getDatabasePath(String dbName) => path;
}

void main() {
  // Initialize FFI for testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late SQLCipherDatabaseService dbService;
  late SearchRepository searchRepo;

  setUp(() async {
    final mockKeyManager = MockMasterKeyManager();
    final mockPathService = MockPathProviderService(inMemoryDatabasePath);

    dbService = SQLCipherDatabaseService(
      keyManager: mockKeyManager,
      pathService: mockPathService,
      dbFactory: databaseFactoryFfi,
    );

    searchRepo = SearchRepository(dbService);

    final db = await dbService.database;
    // Clear tables
    await db.execute('DELETE FROM persons');
    await db.execute('DELETE FROM records');
    await db.execute('DELETE FROM images');
    await db.execute('DELETE FROM tags');
    await db.execute('DELETE FROM ocr_search_index');

    // Seed a person
    await db.insert('persons', {
      'id': 'p1',
      'nickname': 'User 1',
      'created_at_ms': DateTime.now().millisecondsSinceEpoch,
    });
  });

  tearDown(() async {
    await dbService.close();
  });

  group('SearchRepository Chinese Search Tests', () {
    test('Search Chinese characters in OCR text', () async {
      final db = await dbService.database;
      const recordId = 'r1';
      const ocrText = '这是一份包含血常规和心电图的病历报告';

      // Insert record and image
      await db.insert('records', {
        'id': recordId,
        'person_id': 'p1',
        'status': 'archived',
        'created_at_ms': DateTime.now().millisecondsSinceEpoch,
        'updated_at_ms': DateTime.now().millisecondsSinceEpoch,
        'visit_date_ms': DateTime.now().millisecondsSinceEpoch,
      });

      await db.insert('images', {
        'id': 'i1',
        'record_id': recordId,
        'file_path': 'path',
        'thumbnail_path': 'path',
        'encryption_key': 'key',
        'thumbnail_encryption_key': 'key',
        'ocr_text': ocrText,
        'created_at_ms': DateTime.now().millisecondsSinceEpoch,
      });

      // Sync index
      await searchRepo.syncRecordIndex(recordId);

      // Search for "血"
      final resultsSingle = await searchRepo.search('血', 'p1');
      expect(resultsSingle, isNotEmpty);

      // Search for "血*"
      final resultsWildcard = await searchRepo.search('血*', 'p1');
      expect(resultsWildcard, isNotEmpty);

      // Search for "血常规"
      final results = await searchRepo.search('血常规', 'p1');
      expect(results, isNotEmpty);
      expect(results.first.record.id, recordId);
      expect(results.first.snippet, contains('<b>血常规</b>'));

      // Search for "心电图"
      final results2 = await searchRepo.search('心电图', 'p1');
      expect(results2, isNotEmpty);
      expect(results2.first.snippet, contains('<b>心电图</b>'));

      // Search for partial match or related chars
      final results3 = await searchRepo.search('病历', 'p1');
      expect(results3, isNotEmpty);
    });

    test('Search English and Numbers (Regression Test)', () async {
      final db = await dbService.database;
      const recordId = 'r_eng';
      const ocrText = 'Patient ID: 9527, Report ABC-XYZ';

      await db.insert('records', {
        'id': recordId,
        'person_id': 'p1',
        'status': 'archived',
        'created_at_ms': DateTime.now().millisecondsSinceEpoch,
        'updated_at_ms': DateTime.now().millisecondsSinceEpoch,
        'visit_date_ms': DateTime.now().millisecondsSinceEpoch,
      });

      await db.insert('images', {
        'id': 'i_eng',
        'record_id': recordId,
        'file_path': 'path',
        'thumbnail_path': 'path',
        'encryption_key': 'key',
        'thumbnail_encryption_key': 'key',
        'ocr_text': ocrText,
        'created_at_ms': DateTime.now().millisecondsSinceEpoch,
      });

      await searchRepo.syncRecordIndex(recordId);

      // Search for "9527"
      final res1 = await searchRepo.search('9527', 'p1');
      expect(res1, isNotEmpty, reason: 'Numeric search failed');

      // Search for "ABC"
      final res2 = await searchRepo.search('ABC', 'p1');
      expect(res2, isNotEmpty, reason: 'English search failed');

      // Search for "9527 ABC" (Separated by comma in text, should work as AND search)
      final res3 = await searchRepo.search('9527 ABC', 'p1');
      expect(res3, isNotEmpty, reason: 'Multi-word AND search failed');

      // Search for "ABC 9527" (Different order, should work as AND search)
      final res4 = await searchRepo.search('ABC 9527', 'p1');
      expect(
        res4,
        isNotEmpty,
        reason: 'Multi-word unordered AND search failed',
      );
    });

    test('Search Chinese characters in hospital name', () async {
      final db = await dbService.database;
      const recordId = 'r2';
      const hospitalName = '浙江大学医学院附属第一医院';

      await db.insert('records', {
        'id': recordId,
        'person_id': 'p1',
        'status': 'archived',
        'hospital_name': hospitalName,
        'created_at_ms': DateTime.now().millisecondsSinceEpoch,
        'updated_at_ms': DateTime.now().millisecondsSinceEpoch,
        'visit_date_ms': DateTime.now().millisecondsSinceEpoch,
      });

      await searchRepo.syncRecordIndex(recordId);

      final results = await searchRepo.search('浙江大学', 'p1');
      expect(results, isNotEmpty);
      expect(results.first.record.hospitalName, hospitalName);
    });
  });
}
