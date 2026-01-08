/// # BaseRepository
///
/// ## Description
/// 所有 Repository 的基类，提供统一的数据库服务访问入口。
///
/// ## Architecture
/// 属于 Data Layer，持有 `SQLCipherDatabaseService` 的引用。
library;

import 'package:sqflite_sqlcipher/sqflite.dart';
import '../datasources/local/database_service.dart';

abstract class BaseRepository {
  final SQLCipherDatabaseService dbService;

  BaseRepository(this.dbService);

  /// 获取数据库执行器（支持事务）
  /// 如果提供了 [executor]，则使用它；否则获取全局数据库实例。
  Future<DatabaseExecutor> getExecutor([DatabaseExecutor? executor]) async {
    if (executor != null) return executor;
    return dbService.database;
  }
}
