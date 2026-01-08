import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:phf/core/security/file_security_helper.dart';
import 'package:phf/data/datasources/local/database_service.dart';
import 'package:phf/data/models/ocr_result.dart';
import 'package:phf/data/models/record.dart';
import 'package:phf/data/repositories/image_repository.dart';
import 'package:phf/data/repositories/ocr_queue_repository.dart';
import 'package:phf/data/repositories/record_repository.dart';
import 'package:phf/data/repositories/search_repository.dart';
import 'package:phf/core/services/path_provider_service.dart';
import 'package:phf/logic/services/interfaces/ocr_service.dart';
import 'package:phf/logic/services/ocr_processor.dart';

import 'ocr_processor_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IOCRService>(),
  MockSpec<FileSecurityHelper>(),
  MockSpec<PathProviderService>(),
  MockSpec<SQLCipherDatabaseService>(),
])
void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late MockSQLCipherDatabaseService mockDbService;
  late MockIOCRService mockOcrService;
  late MockFileSecurityHelper mockSecurityHelper;
  late MockPathProviderService mockPathService;

  late OCRQueueRepository queueRepo;
  late ImageRepository imageRepo;
  late RecordRepository recordRepo;
  late SearchRepository searchRepo;
  late OCRProcessor processor;

  setUp(() async {
    mockDbService = MockSQLCipherDatabaseService();
    mockOcrService = MockIOCRService();
    mockSecurityHelper = MockFileSecurityHelper();
    mockPathService = MockPathProviderService();

    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    // Setup Schema
    await db.execute(
      'CREATE TABLE records (id TEXT PRIMARY KEY, person_id TEXT, status TEXT, visit_date_ms INTEGER, visit_date_iso TEXT, hospital_name TEXT, notes TEXT, tags_cache TEXT, visit_end_date_ms INTEGER, created_at_ms INTEGER, updated_at_ms INTEGER)',
    );
    await db.execute(
      'CREATE TABLE images (id TEXT PRIMARY KEY, record_id TEXT, file_path TEXT, thumbnail_path TEXT, encryption_key TEXT, thumbnail_encryption_key TEXT, width INTEGER, height INTEGER, hospital_name TEXT, visit_date_ms INTEGER, mime_type TEXT, file_size INTEGER, page_index INTEGER, ocr_text TEXT, ocr_raw_json TEXT, ocr_confidence REAL, tags TEXT, created_at_ms INTEGER)',
    );
    await db.execute(
      'CREATE TABLE ocr_queue (id TEXT PRIMARY KEY, image_id TEXT, status TEXT, retry_count INTEGER, last_error TEXT, created_at_ms INTEGER, updated_at_ms INTEGER)',
    );
    await db.execute(
      'CREATE VIRTUAL TABLE ocr_search_index USING fts5(record_id UNINDEXED, person_id UNINDEXED, hospital_name, tags, ocr_text, notes, content)',
    );

    when(mockDbService.database).thenAnswer((_) async => db);
    when(mockPathService.sandboxRoot).thenReturn('/sandbox');

    queueRepo = OCRQueueRepository(mockDbService);
    imageRepo = ImageRepository(mockDbService);
    recordRepo = RecordRepository(mockDbService);
    searchRepo = SearchRepository(mockDbService);

    processor = OCRProcessor(
      queueRepository: queueRepo,
      imageRepository: imageRepo,
      recordRepository: recordRepo,
      searchRepository: searchRepo,
      ocrService: mockOcrService,
      securityHelper: mockSecurityHelper,
      pathService: mockPathService,
      dbService: mockDbService,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('OCRProcessor', () {
    test('processNextItem returns false when queue is empty', () async {
      final result = await processor.processNextItem();
      expect(result, isFalse);
    });

    test('Full success flow (High Confidence)', () async {
      // 1. Setup Data
      await db.insert('records', {
        'id': 'rec1',
        'person_id': 'p1',
        'status': 'processing',
        'created_at_ms': 0,
        'updated_at_ms': 0,
      });
      await db.insert('images', {
        'id': 'img1',
        'record_id': 'rec1',
        'file_path': '/path',
        'encryption_key': 'key',
        'thumbnail_encryption_key': 'tk',
        'thumbnail_path': '/t',
        'created_at_ms': 0,
      });
      await db.insert('ocr_queue', {
        'id': 'q1',
        'image_id': 'img1',
        'status': 'pending',
        'retry_count': 0,
        'created_at_ms': 0,
        'updated_at_ms': 0,
      });

      final decryptedBytes = Uint8List(10);
      const ocrResult = OcrResult(
        text: '2023-10-10\nHospital A',
        confidence: 0.95,
      );

      when(
        mockSecurityHelper.decryptDataFromFile(any, any),
      ).thenAnswer((_) async => decryptedBytes);
      when(
        mockOcrService.recognizeText(any, mimeType: anyNamed('mimeType')),
      ).thenAnswer((_) async => ocrResult);

      final result = await processor.processNextItem();

      expect(result, isTrue);

      // Verify DB state
      final img = await imageRepo.getImageById('img1');
      expect(img?.ocrText, contains('Hospital A'));
      expect(img?.ocrConfidence, 0.95);

      final rec = await recordRepo.getRecordById('rec1');
      expect(rec?.status, RecordStatus.archived);

      final job = await db.query('ocr_queue', where: "id='q1'");
      expect(job.first['status'], 'completed');
    });

    test('Low confidence flow (Processing -> Review)', () async {
      await db.insert('records', {
        'id': 'rec1',
        'person_id': 'p1',
        'status': 'processing',
        'created_at_ms': 0,
        'updated_at_ms': 0,
      });
      await db.insert('images', {
        'id': 'img1',
        'record_id': 'rec1',
        'file_path': '/path',
        'encryption_key': 'key',
        'thumbnail_encryption_key': 'tk',
        'thumbnail_path': '/t',
        'created_at_ms': 0,
      });
      await db.insert('ocr_queue', {
        'id': 'q1',
        'image_id': 'img1',
        'status': 'pending',
        'retry_count': 0,
        'created_at_ms': 0,
        'updated_at_ms': 0,
      });

      const ocrResult = OcrResult(text: 'No Clear Data', confidence: 0.5);

      when(
        mockSecurityHelper.decryptDataFromFile(any, any),
      ).thenAnswer((_) async => Uint8List(0));
      when(
        mockOcrService.recognizeText(any, mimeType: anyNamed('mimeType')),
      ).thenAnswer((_) async => ocrResult);

      await processor.processNextItem();

      final rec = await recordRepo.getRecordById('rec1');
      expect(rec?.status, RecordStatus.review);
    });

    test('Failure handling', () async {
      await db.insert('ocr_queue', {
        'id': 'q1',
        'image_id': 'img_not_exists',
        'status': 'pending',
        'retry_count': 0,
        'created_at_ms': 0,
        'updated_at_ms': 0,
      });

      final result = await processor.processNextItem();

      expect(result, isFalse);
      final job = await db.query('ocr_queue', where: "id='q1'");
      expect(job.first['status'], 'failed');
    });
  });
}
