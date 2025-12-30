/// # TagRepository Implementation
///
/// 使用 `databaseService` 访问 `tags` 表。

import '../datasources/local/database_service.dart';
import '../models/tag.dart';
import 'interfaces/tag_repository.dart';

class TagRepository implements ITagRepository {
  final SQLCipherDatabaseService _dbService;

  TagRepository(this._dbService);

  @override
  Future<List<Tag>> getAllTags() async {
    print('TagRepository: Getting all tags...'); // Debug
    try {
      final db = await _dbService.database;
      print('TagRepository: DB acquired.');
      final maps = await db.query(
        'tags',
        orderBy: 'order_index ASC',
      );
      print('TagRepository: Query success. Rows: ${maps.length}');
      return maps.map((e) => Tag(
        id: e['id'] as String,
        name: e['name'] as String,
        color: (e['color'] as String?) ?? '#808080',
        isSystem: (e['is_custom'] as int?) == 0,
        personId: e['person_id'] as String?,
        createdAt: DateTime.fromMillisecondsSinceEpoch(e['created_at_ms'] as int),
      )).toList();
    } catch (e, st) {
      print('TagRepository: Error getting tags: $e\n$st');
      rethrow;
    }
  }
}
