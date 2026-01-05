/// # Timeline Filter Sheet
///
/// ## Description
/// 时间轴过滤面板，支持按日期范围和标签进行多维筛选。
/// 遵循 `Constitution#VI. UI/UX` 准则，使用 Teal 主色调和圆角设计。
///
/// ## 修复记录
/// - [issue#22] 实现日期范围选择与多标签筛选 UI。
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phf/logic/providers/core_providers.dart';
import 'package:phf/logic/providers/timeline_provider.dart';
import 'package:phf/data/models/tag.dart';
import 'package:phf/presentation/theme/app_theme.dart';

class TimelineFilterSheet extends ConsumerStatefulWidget {
  const TimelineFilterSheet({super.key});

  @override
  ConsumerState<TimelineFilterSheet> createState() =>
      _TimelineFilterSheetState();
}

class _TimelineFilterSheetState extends ConsumerState<TimelineFilterSheet> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    // 从现有状态初始化
    final currentState = ref.read(timelineControllerProvider).value;
    if (currentState != null) {
      _startDate = currentState.startDate;
      _endDate = currentState.endDate;
      _selectedTags = List.from(currentState.filterTags ?? []);
    }
  }

  void _reset() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _selectedTags = [];
    });
  }

  void _apply() {
    ref
        .read(timelineControllerProvider.notifier)
        .search(
          tags: _selectedTags.isEmpty ? null : _selectedTags,
          startDate: _startDate,
          endDate: _endDate,
        );
    Navigator.pop(context);
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryTeal,
              onPrimary: Colors.white,
              onSurface: AppTheme.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTagsAsync = ref.watch(allTagsProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '筛选条件',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton(
                onPressed: _reset,
                child: const Text(
                  '重置',
                  style: TextStyle(color: AppTheme.textHint),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '日期范围',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _selectDateRange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.bgGrey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _startDate == null || _endDate == null
                        ? '选择日期范围'
                        : '${DateFormat('yyyy-MM-dd').format(_startDate!)} 至 ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _startDate == null
                          ? AppTheme.textHint
                          : AppTheme.textPrimary,
                      fontFamily: AppTheme.fontPool,
                    ),
                  ),
                  const Spacer(),
                  if (_startDate != null)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _startDate = null;
                          _endDate = null;
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppTheme.textHint,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            '标签 (多选)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          allTagsAsync.when(
            data: (tags) {
              if (tags.isEmpty) {
                return const Text(
                  '暂无可用标签',
                  style: TextStyle(color: AppTheme.textHint, fontSize: 13),
                );
              }
              // 按名称排序
              final sortedTags = List<Tag>.from(tags)
                ..sort((a, b) => a.name.compareTo(b.name));

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sortedTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag.name);
                  return FilterChip(
                    label: Text(tag.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag.name);
                        } else {
                          _selectedTags.remove(tag.name);
                        }
                      });
                    },
                    selectedColor: AppTheme.primaryTeal.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.primaryTeal,
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? AppTheme.primaryTeal
                          : AppTheme.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryTeal
                            : const Color(0xFFE5E5EA),
                      ),
                    ),
                    backgroundColor: Colors.white,
                  );
                }).toList(),
              );
            },
            loading: () => const SizedBox(
              height: 40,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (err, _) => Text('加载失败: $err'),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                '确认筛选',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
