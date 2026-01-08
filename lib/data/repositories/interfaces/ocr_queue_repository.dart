/// # IOCRQueueRepository Interface
///
/// ## Description
/// OCR 异步处理队列的业务契约。
///
/// ## Functions
/// - `enqueue`: 将任务加入队列.
/// - `dequeue`: 获取下一个待处理任务.
/// - `updateStatus`: 更新任务状态.
/// - `getPendingCount`: 获取待处理任务总数.
library;

import 'package:sqflite_sqlcipher/sqflite.dart';
import '../../models/ocr_queue_item.dart';

abstract interface class IOCRQueueRepository {
  /// 加入队列
  Future<void> enqueue(String imageId, {DatabaseExecutor? executor});

  /// 批量加入队列
  Future<void> enqueueBatch(
    List<String> imageIds, {
    DatabaseExecutor? executor,
  });

  /// 获取下一个待处理任务
  Future<OCRQueueItem?> dequeue({DatabaseExecutor? executor});

  /// 更新任务状态
  Future<void> updateStatus(
    String id,
    OCRJobStatus status, {
    String? error,
    DatabaseExecutor? executor,
  });

  /// 增加重试次数
  Future<void> incrementRetry(String id, {DatabaseExecutor? executor});

  /// 获取待处理任务数
  Future<int> getPendingCount({String? personId, DatabaseExecutor? executor});

  /// 删除任务
  Future<void> deleteJob(String id, {DatabaseExecutor? executor});

  /// 根据图片 ID 删除任务
  Future<void> deleteByImageId(String imageId, {DatabaseExecutor? executor});
}
