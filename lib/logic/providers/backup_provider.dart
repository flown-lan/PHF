/// # Backup Provider
///
/// ## Description
/// 处理备份导出与导入的高层状态。
/// 串联 [BackupService] 与 share_plus 插件。
/// ## Repair Logs
/// - [2026-01-08] 修复：
///   1. 增强恢复后的 Provider 重置逻辑：显式重置 `allPersonsProvider`、`currentPersonIdControllerProvider` 与 `timelineControllerProvider`，确保 UI 能够立即感知并展示恢复后的数据（解决 Issue #96）。
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';
// ignore: deprecated_member_use
import 'package:share_plus/share_plus.dart';
import '../services/backup_service.dart';
import 'core_providers.dart';
import 'logging_provider.dart';
import 'person_provider.dart';
import 'timeline_provider.dart';

part 'backup_provider.g.dart';

@riverpod
class BackupController extends _$BackupController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  /// 导出备份并分享
  Future<void> exportAndShare(String pin) async {
    state = const AsyncValue.loading();
    final talker = ref.read(talkerProvider);

    state = await AsyncValue.guard(() async {
      final service = ref.read(backupServiceProvider);

      talker.info('[BackupController] Starting export...');
      final path = await service.exportBackup(pin);

      talker.info('[BackupController] Export finished. Triggering share.');
      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(path)], subject: 'PaperHealth 安全备份');
    });
  }

  /// 导入备份
  Future<void> importFromFile(String path, String pin) async {
    state = const AsyncValue.loading();
    final talker = ref.read(talkerProvider);

    state = await AsyncValue.guard(() async {
      final service = ref.read(backupServiceProvider);

      talker.info('[BackupController] Closing database connection...');
      // 断开数据库连接以允许文件覆盖
      ref.invalidate(databaseServiceProvider);

      talker.info('[BackupController] Starting import from $path');
      await service.importBackup(path, pin);

      talker.info(
        '[BackupController] Import successful. Re-initializing database.',
      );

      // 再次重置，确保后续读取获得最新连接
      ref.invalidate(databaseServiceProvider);

      // 显式重置核心业务 Provider，强制 UI 刷新（针对 Issue #96）
      ref.invalidate(allPersonsProvider);
      ref.invalidate(currentPersonIdControllerProvider);
      ref.invalidate(timelineControllerProvider);
    });
  }
}
