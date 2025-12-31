/// # OCR Status Provider
///
/// ## Description
/// 监听并广播 OCR 队列的待处理任务数量。
/// 采用定时轮询策略（离线环境下最稳健的跨 Isolate 状态同步方式）。
///
/// ## Mechanics
/// - 任务数 > 0 时：每 3 秒轮询一次。
/// - 任务数 = 0 时：每 10 秒轮询一次（降低功耗）。
///
/// ## Security
/// - 仅读取任务计数，不涉及敏感明文。
library;

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'core_providers.dart';

part 'ocr_status_provider.g.dart';

@riverpod
Stream<int> ocrPendingCount(Ref ref) async* {
  final repo = ref.watch(ocrQueueRepositoryProvider);
  
  // 用于手动触发刷新的控制
  // ignore: unused_local_variable
  final keepAlive = ref.keepAlive();

  while (true) {
    int count = 0;
    try {
      count = await repo.getPendingCount();
    } catch (e) {
      // 数据库忙或锁定，暂报 0 并等待下一次
      count = 0;
    }
    
    yield count;

    // 根据是否有任务调整轮询频率
    if (count > 0) {
      await Future.delayed(const Duration(seconds: 3));
    } else {
      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
