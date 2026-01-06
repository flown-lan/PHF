import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/search_result.dart';
import 'core_providers.dart';
import 'person_provider.dart';

part 'search_provider.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  FutureOr<List<SearchResult>> build() {
    // 异步触发全量重索引，确保旧数据在升级后能被搜到
    _ensureReindexed();
    return [];
  }

  Future<void> _ensureReindexed() async {
    final metaRepo = ref.read(appMetaRepositoryProvider);
    const reindexKey = 'fts_reindexed_v9';
    final isDone = await metaRepo.get(reindexKey);

    if (isDone != 'true') {
      final repo = ref.read(searchRepositoryProvider);
      await repo.reindexAll();
      await metaRepo.put(reindexKey, 'true');
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    final personId = await ref.read(currentPersonIdControllerProvider.future);
    if (personId == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(searchRepositoryProvider);
      return repo.search(query, personId);
    });
  }
}
