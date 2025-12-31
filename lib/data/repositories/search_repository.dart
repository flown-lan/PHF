/// # SearchRepository Implementation
///
/// ## Description
/// `ISearchRepository` 的具体实现。
///
/// ## Security
/// - 基于 SQLCipher 加密环境。
/// - FTS5 索引存储在加密数据库内部。
library;

import '../models/record.dart';
import 'base_repository.dart';
import 'interfaces/search_repository.dart';

class SearchRepository extends BaseRepository implements ISearchRepository {
  SearchRepository(super.dbService);

  @override
  Future<List<MedicalRecord>> search(String query, String personId) async {
    final db = await dbService.database;
    
    // 执行 FTS5 全文搜索
    // JOIN records 表以获取元数据，并过滤 personId
    final sql = '''
      SELECT r.* 
      FROM records r
      JOIN ocr_search_index fts ON r.id = fts.record_id
      WHERE r.person_id = ? AND r.status != 'deleted' AND fts.content MATCH ?
      ORDER BY r.visit_date_ms DESC
    ''';
    
    final List<Map<String, dynamic>> maps = await db.rawQuery(sql, [personId, query]);
    
    return maps.map((m) {
      return MedicalRecord(
        id: m['id'] as String,
        personId: m['person_id'] as String,
        hospitalName: m['hospital_name'] as String?,
        notes: m['notes'] as String?,
        notedAt: DateTime.fromMillisecondsSinceEpoch(m['visit_date_ms'] as int),
        visitEndDate: m['visit_end_date_ms'] != null 
            ? DateTime.fromMillisecondsSinceEpoch(m['visit_end_date_ms'] as int) 
            : null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(m['created_at_ms'] as int),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(m['updated_at_ms'] as int),
        status: RecordStatus.values.firstWhere((e) => e.name == m['status']),
        tagsCache: m['tags_cache'] as String?,
      );
    }).toList();
  }

  @override
  Future<void> updateIndex(String recordId, String content) async {
    final db = await dbService.database;
    
    // SQLite FTS5 不支持直接 REPLACE，通常先 DELETE 再 INSERT
    await db.transaction((txn) async {
      await txn.delete('ocr_search_index', where: 'record_id = ?', whereArgs: [recordId]);
      await txn.insert('ocr_search_index', {
        'record_id': recordId,
        'content': content,
      });
    });
  }

  @override
  Future<void> deleteIndex(String recordId) async {
    final db = await dbService.database;
    await db.delete('ocr_search_index', where: 'record_id = ?', whereArgs: [recordId]);
  }
}
