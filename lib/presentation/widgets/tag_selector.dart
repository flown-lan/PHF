import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/providers/core_providers.dart';
import '../../data/models/tag.dart';
import '../theme/app_theme.dart';

class TagSelector extends ConsumerStatefulWidget {
  final List<String> selectedTagIds;
  final Function(String) onToggle;
  final Function(int, int) onReorder;

  const TagSelector({
    super.key,
    required this.selectedTagIds,
    required this.onToggle,
    required this.onReorder,
  });

  @override
  ConsumerState<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends ConsumerState<TagSelector> {
  // Simple local cache needed? Or just watch repository?
  // Since repo is async, we use FutureBuilder or Riverpod FutureProvider wrapper.
  // For simplicity, we'll fetch once in initState or use FutureBuilder.
  
  late Future<List<Tag>> _tagsFuture;

  @override
  void initState() {
    super.initState();
    // Assuming tagRepository is available and we want all tags
    _tagsFuture = ref.read(tagRepositoryProvider).getAllTags().timeout(const Duration(seconds: 5), onTimeout: () => throw 'Timeout loading tags');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tag>>(
      future: _tagsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('TagSelector: Error snapshot: ${snapshot.error}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('加载标签失败: ${snapshot.error}', style: const TextStyle(color: AppTheme.errorRed)),
          );
        }
        
        if (!snapshot.hasData) {
          print('TagSelector: Waiting for data...');
          return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
        }

        final allTags = snapshot.data!;
        print('TagSelector: Data received. Count: ${allTags.length}');
        // Segregate selected vs unselected for UI clarity or keep single list?
        // Requirement: "support drag to reorder"
        // If we reorder, are we reordering the SELECTION or the AVAILABLE tags?
        // Usually "drag to reorder" implies reordering the applied tags (priority).
        
        // Let's implement:
        // 1. "Selected Tags" area (Reorderable)
        // 2. "Available Tags" area (Click to add)

        final selectedTags = widget.selectedTagIds
            .map((id) => allTags.firstWhere((t) => t.id == id, orElse: () => Tag(id: id, name: 'Unknown', createdAt: DateTime.now(), color: '#888888')))
            .toList();
            
        final unselectedTags = allTags.where((t) => !widget.selectedTagIds.contains(t.id)).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedTags.isNotEmpty) ...[
              const Text('已选标签 (拖动排序)', style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
              const SizedBox(height: 8),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: widget.onReorder,
                children: [
                  for (final tag in selectedTags)
                    ListTile(
                      key: ValueKey(tag.id),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.label, color: AppTheme.primaryTeal),
                      title: Text(tag.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.errorRed),
                        onPressed: () => widget.onToggle(tag.id),
                      ),
                    ),
                ],
              ),
              const Divider(),
            ],
            
            if (unselectedTags.isNotEmpty) ...[
              const Text('可用标签', style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: unselectedTags.map((tag) {
                  return ActionChip(
                    label: Text(tag.name),
                    backgroundColor: AppTheme.bgGray,
                    onPressed: () => widget.onToggle(tag.id),
                  );
                }).toList(),
              ),
            ],
          ],
        );
      },
    );
  }
}
