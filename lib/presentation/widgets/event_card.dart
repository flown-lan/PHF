// EventCard Component
//
// Description:
// Timeline 上展示单个就诊记录的卡片组件。
//
// Features:
// - Header: 显示就诊日期 (Inconsolata) 和 医院名称。
// - Body: 使用 SecureImage 展示首张缩略图。
// - Footer: 展示去重后的 Tags 列表。

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/image.dart';
import '../../data/models/record.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/secure_image.dart';

class EventCard extends StatelessWidget {
  final MedicalRecord record;
  final MedicalImage? firstImage;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.record,
    this.firstImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd').format(record.notedAt);
    
    // Parse tags from JSON cache
    final List<String> tags = _parseTags(record.tagsCache);

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero, // Custom layout inside
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Header (Date + Hospital)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                // Date Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.bgGray,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    dateStr,
                    style: AppTheme.monoStyle.copyWith(
                      fontSize: 12,
                      color: AppTheme.textHint,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Hospital Name
                Expanded(
                  child: Text(
                    record.hospitalName ?? '未命名记录',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Status Dot (e.g. if processing, show distinct indicator - Phase 2)
              ],
            ),
          ),

          // 2. Body (Thumbnail)
          if (firstImage != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: SecureImage(
                imagePath: firstImage!.thumbnailPath, // Use thumbnail for list view
                encryptionKey: firstImage!.encryptionKey,
                fit: BoxFit.cover,
                // No radius here, or distinct radius? 
                // Let's keep it straight as it's middle content
              ),
            )
          else
            Container(
              height: 120,
              color: AppTheme.bgGray,
              alignment: Alignment.center,
              child: const Icon(Icons.medical_services_outlined, color: AppTheme.textHint, size: 48),
            ),

          // 3. Footer (Tags + Note Snippet)
          if (tags.isNotEmpty || (record.notes?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tags.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: tags.map((t) => _buildTagChip(t)).toList(),
                    ),
                  if (tags.isNotEmpty && (record.notes?.isNotEmpty ?? false))
                    const SizedBox(height: 6),
                  if (record.notes?.isNotEmpty ?? false)
                    Text(
                      record.notes!,
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.primaryLight.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppTheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<String> _parseTags(String? jsonCache) {
    if (jsonCache == null || jsonCache.isEmpty) return [];
    try {
      // Expecting JSON array of strings: '["Check", "Blood"]'
      // Or relying on Data Layer convention.
      final List<dynamic> list = jsonDecode(jsonCache) as List<dynamic>;
      return list.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
  }
}
