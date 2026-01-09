/// # FocusZoomOverlay Component
///
/// ## Description
/// 字段聚焦放大预览组件。用于在编辑 OCR 结果时，弹出一个局部放大的原始图片区域，方便对照校对。
///
/// ## Features
/// - **Secure**: 继承 `SecureImage` 的内存解密逻辑，不留磁盘痕迹。
/// - **Layout-Aware**: 接收归一化坐标 [x, y, w, h]，自动计算裁剪区域。
/// - **Visual Aid**: 提供高亮边框和阴影，增强层级感。
///
/// ## Repair Logs
/// - [2026-01-09] 修复：增加了裁剪比例的边界保护 (clamp)，并完善了裁剪计算逻辑。
library;

import 'package:flutter/material.dart';
import 'secure_image.dart';
import '../theme/app_theme.dart';

class FocusZoomOverlay extends StatelessWidget {
  final String imagePath;
  final String encryptionKey;
  final List<double> normalizedRect; // [x, y, w, h] (0.0 - 1.0)
  final double scale;

  const FocusZoomOverlay({
    super.key,
    required this.imagePath,
    required this.encryptionKey,
    required this.normalizedRect,
    this.scale = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    if (normalizedRect.length < 4) return const SizedBox();

    // 边界检查与规范化
    final w = normalizedRect[2].clamp(0.01, 1.0);
    final h = normalizedRect[3].clamp(0.01, 1.0);
    final x = normalizedRect[0].clamp(0.0, 1.0 - w);
    final y = normalizedRect[1].clamp(0.0, 1.0 - h);

    return Container(
      height: 140, // 稍微增加预览高度
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryTeal, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: SecureImage(
        imagePath: imagePath,
        encryptionKey: encryptionKey,
        fit: BoxFit.none,
        builder: (context, imageProvider) {
          return LayoutBuilder(
            builder: (context, constraints) {
              // 计算 Alignment:
              // Alignment(x, y) 范围是 -1 到 1.
              // 0.0 -> -1.0, 0.5 -> 0.0, 1.0 -> 1.0
              // 使用裁剪区域的中心点
              final alignmentX = (x + w / 2) * 2 - 1;
              final alignmentY = (y + h / 2) * 2 - 1;

              return FractionallySizedBox(
                // 根据 scale 放大
                widthFactor: scale / w,
                heightFactor: scale / h,
                child: Container(
                  alignment: Alignment(alignmentX, alignmentY),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.white54),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
