/// # Timeline Page
///
/// ## Description
/// 首页时间轴页面，展示用户的医疗记录列表。
///
/// ## Features
/// - **List View**: 使用 `EventCard` 展示记录摘要。
/// - **Pull to Refresh**: 下拉刷新列表。
/// - **Navigation**: 点击卡片调整至详情页。
/// - **Empty State**: 无记录时展示引导提示。

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phf/data/models/record.dart';
import 'package:phf/logic/providers/core_providers.dart';
import 'package:phf/presentation/theme/app_theme.dart';
import 'package:phf/presentation/widgets/event_card.dart';
import 'record_detail_page.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  // Phase 1: Hardcoded 'def_me' user
  static const String _currentUserId = 'def_me';
  
  List<MedicalRecord> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repo = ref.read(recordRepositoryProvider);
      final records = await repo.getRecordsByPerson(_currentUserId);
      
      // Load first image for each record to display thumbnails in EventCard
      // This is an N+1 query optimization trade-off. 
      // Ideally Repo supports eager loading or we do it here.
      // Given Phase 1 local DB speed, doing it in loop is acceptable for MVP.
      final imageRepo = ref.read(imageRepositoryProvider);
      
      final List<MedicalRecord> enrichedRecords = [];
      for (var rec in records) {
        final images = await imageRepo.getImagesForRecord(rec.id);
        // We only attach images to memory model without impacting functionality
        // EventCard picks firstImage from parameters or record.images
        enrichedRecords.add(rec.copyWith(images: images));
      }

      if (mounted) {
        setState(() {
          _records = enrichedRecords;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    }
  }

  void _navigateToDetail(MedicalRecord record) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RecordDetailPage(recordId: record.id)),
    );
    // Refresh after return (in case of edits/deletes)
    _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_records.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_2_outlined, size: 64, color: AppTheme.textHint),
            const SizedBox(height: 16),
            const Text(
              '暂无记录，点击右下角 + 号开始录入',
              style: TextStyle(color: AppTheme.textHint),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRecords,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _records.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final record = _records[index];
          final firstImage = record.images.isNotEmpty ? record.images.first : null;
          
          return EventCard(
            record: record,
            firstImage: firstImage,
            onTap: () => _navigateToDetail(record),
          );
        },
      ),
    );
  }
}
