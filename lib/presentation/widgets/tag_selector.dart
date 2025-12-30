import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/providers/core_providers.dart';
import '../../data/models/tag.dart';
import '../theme/app_theme.dart';

class TagSelector extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final allTagsAsync = ref.watch(allTagsProvider);

    return allTagsAsync.when(
      data: (allTags) => _buildContent(context, allTags),
      loading: () => const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('加载标签失败: $err',
            style: const TextStyle(color: AppTheme.errorRed, fontSize: 12)),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Tag> allTags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. All Tags Library (The Selection Area)
        const Text('全量标签 (点击切换选中)', 
            style: TextStyle(fontSize: 12, color: AppTheme.textHint, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allTags.map((tag) {
            final isSelected = selectedTagIds.contains(tag.id);
            return FilterChip(
              label: Text(tag.name),
              selected: isSelected,
              onSelected: (_) => onToggle(tag.id),
              showCheckmark: true,
              selectedColor: AppTheme.primaryTeal.withValues(alpha: 0.15),
              checkmarkColor: AppTheme.primaryTeal,
              labelStyle: TextStyle(
                fontSize: 13,
                color: isSelected ? AppTheme.primaryTeal : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppTheme.primaryTeal : Colors.transparent,
                  width: 1,
                ),
              ),
              backgroundColor: AppTheme.bgGrey,
            );
          }).toList(),
        ),

        if (selectedTagIds.length > 1) ...[
          const SizedBox(height: 32),
          const Row(
            children: [
              Icon(Icons.swap_vert, size: 16, color: AppTheme.textHint),
              SizedBox(width: 4),
              Text('拖拽排序 (决定展示优先级)', 
                  style: TextStyle(fontSize: 12, color: AppTheme.textHint, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.bgGrey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.bgGrey),
            ),
            child: ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: onReorder,
              proxyDecorator: (child, index, animation) {
                return Material(
                  color: Colors.transparent,
                  child: child,
                );
              },
              children: [
                for (int i = 0; i < selectedTagIds.length; i++)
                  _buildReorderItem(allTags, selectedTagIds[i], i),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReorderItem(List<Tag> allTags, String id, int index) {
    final tag = allTags.firstWhere((t) => t.id == id, orElse: () => Tag(id: id, name: '?', createdAt: DateTime(0), color: ''));
    return ListTile(
      key: ValueKey('reorder_$id'),
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppTheme.primaryTeal,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      title: Text(tag.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.drag_handle, color: AppTheme.textHint, size: 20),
    );
  }
}