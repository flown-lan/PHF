/// # OCRQueueRepository Implementation
///
/// ## Description
/// `IOCRQueueRepository` 的具体实现。
///
/// ## Security
/// - 所有操作在 SQL 事务架构下进行，确保队列一致性。
///
/// ## Fix Record
/// - **2025-12-31**: 修复了缺少 `sqflite` 包引用导致的编译错误 (Undefined name 'Sqflite')。
library;

import 'package:uuid/uuid.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import '../models/ocr_queue_item.dart';
import 'base_repository.dart';
import 'interfaces/ocr_queue_repository.dart';

class OCRQueueRepository extends BaseRepository implements IOCRQueueRepository {
  OCRQueueRepository(super.dbService);

  @override
  Future<void> enqueue(String imageId, {DatabaseExecutor? executor}) async {
    final exec = await getExecutor(executor);
    final now = DateTime.now().millisecondsSinceEpoch;

    Future<void> logic(DatabaseExecutor e) async {
      // Check if a job already exists for this image
      final existing = await e.query(
        'ocr_queue',
        where: 'image_id = ?',
        whereArgs: [imageId],
        limit: 1,
      );

      if (existing.isNotEmpty) {
        // Reset existing job to pending
        await e.update(
          'ocr_queue',
          {
            'status': OCRJobStatus.pending.name,
            'retry_count': 0,
            'last_error': null,
            'updated_at_ms': now,
          },
          where: 'image_id = ?',
          whereArgs: [imageId],
        );
      } else {
        // Create new job
        await e.insert('ocr_queue', {
          'id': const Uuid().v4(),
          'image_id': imageId,
          'status': OCRJobStatus.pending.name,
          'retry_count': 0,
          'created_at_ms': now,
          'updated_at_ms': now,
        });
      }
    }

    if (executor == null && exec is Database) {
      await exec.transaction((txn) => logic(txn));
    } else {
      await logic(exec);
    }
  }

  @override
  Future<void> enqueueBatch(
    List<String> imageIds, {
    DatabaseExecutor? executor,
  }) async {
    final exec = await getExecutor(executor);
    final now = DateTime.now().millisecondsSinceEpoch;

    Future<void> logic(DatabaseExecutor e) async {
      if (imageIds.isEmpty) return;

      // 1. Bulk Query to find existing jobs
      final placeholder = List.filled(imageIds.length, '?').join(',');
      final existingRows = await e.query(
        'ocr_queue',
        columns: ['image_id'],
        where: 'image_id IN ($placeholder)',
        whereArgs: imageIds,
      );

      final existingImageIds = existingRows
          .map((r) => r['image_id'] as String)
          .toSet();
      final newImageIds = imageIds
          .where((id) => !existingImageIds.contains(id))
          .toList();

      final batch = e.batch();

      // 2. Batch Update existing
      for (final id in existingImageIds) {
        batch.update(
          'ocr_queue',
          {
            'status': OCRJobStatus.pending.name,
            'retry_count': 0,
            'last_error': null,
            'updated_at_ms': now,
          },
          where: 'image_id = ?',
          whereArgs: [id],
        );
      }

      // 3. Batch Insert new
      for (final id in newImageIds) {
        batch.insert('ocr_queue', {
          'id': const Uuid().v4(),
          'image_id': id,
          'status': OCRJobStatus.pending.name,
          'retry_count': 0,
          'created_at_ms': now,
          'updated_at_ms': now,
        });
      }

      await batch.commit(noResult: true);
    }

    if (executor == null && exec is Database) {
      await exec.transaction((txn) => logic(txn));
    } else {
      await logic(exec);
    }
  }

  @override
  Future<OCRQueueItem?> dequeue({DatabaseExecutor? executor}) async {
    final exec = await getExecutor(executor);

    // 获取一个 pending 状态的任务
    final maps = await exec.query(
      'ocr_queue',
      where: 'status = ?',
      whereArgs: [OCRJobStatus.pending.name],
      orderBy: 'created_at_ms ASC',
      limit: 1,
    );

    if (maps.isEmpty) return null;

    final row = maps.first;
    return OCRQueueItem(
      id: row['id'] as String,
      imageId: row['image_id'] as String,
      status: OCRJobStatus.values.firstWhere((e) => e.name == row['status']),
      retryCount: row['retry_count'] as int,
      lastError: row['last_error'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        row['created_at_ms'] as int,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        row['updated_at_ms'] as int,
      ),
    );
  }

  @override
  Future<void> updateStatus(
    String id,
    OCRJobStatus status, {
    String? error,
    DatabaseExecutor? executor,
  }) async {
    final exec = await getExecutor(executor);
    await exec.update(
      'ocr_queue',
      {
        'status': status.name,
        'last_error': error,
        'updated_at_ms': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> incrementRetry(String id, {DatabaseExecutor? executor}) async {
    final exec = await getExecutor(executor);
    await exec.execute(
      'UPDATE ocr_queue SET retry_count = retry_count + 1, updated_at_ms = ? WHERE id = ?',
      [DateTime.now().millisecondsSinceEpoch, id],
    );
  }

  @override
  Future<int> getPendingCount({
    String? personId,
    DatabaseExecutor? executor,
  }) async {
    final exec = await getExecutor(executor);

    if (personId == null) {
      final count = Sqflite.firstIntValue(
        await exec.rawQuery('SELECT COUNT(*) FROM ocr_queue WHERE status = ?', [
          OCRJobStatus.pending.name,
        ]),
      );
      return count ?? 0;
    } else {
      final count = Sqflite.firstIntValue(
        await exec.rawQuery(
          '''
          SELECT COUNT(*) 
          FROM ocr_queue q
          JOIN images i ON q.image_id = i.id
          JOIN records r ON i.record_id = r.id
          WHERE q.status = ? AND r.person_id = ?
          ''',
          [OCRJobStatus.pending.name, personId],
        ),
      );
      return count ?? 0;
    }
  }

  @override
  Future<void> deleteJob(String id, {DatabaseExecutor? executor}) async {
    final exec = await getExecutor(executor);
    await exec.delete('ocr_queue', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteByImageId(
    String imageId, {
    DatabaseExecutor? executor,
  }) async {
    final exec = await getExecutor(executor);
    await exec.delete('ocr_queue', where: 'image_id = ?', whereArgs: [imageId]);
  }
}
