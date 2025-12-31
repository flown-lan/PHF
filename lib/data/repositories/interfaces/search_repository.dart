/// # ISearchRepository Interface
///
/// ## Description
/// 全文搜索业务契约。
/// 基于 FTS5 实现高效的 OCR 文本检索。
///
/// ## Functions
/// - `search`: 执行全文搜索并返回匹配的 Record 列表.
/// - `updateIndex`: 更新搜索索引.
library;

import '../../models/record.dart';

abstract interface class ISearchRepository {
  /// 执行全文搜索
  /// 返回符合条件的 MedicalRecord 列表（不带完整图片元数据）
  Future<List<MedicalRecord>> search(String query, String personId);

  /// 更新或插入 OCR 索引
  Future<void> updateIndex(String recordId, String content);

  /// 删除索引
  Future<void> deleteIndex(String recordId);
}
