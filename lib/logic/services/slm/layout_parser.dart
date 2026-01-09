/// # Layout Parser
///
/// ## Description
/// 基于坐标聚类算法，将 OCR 识别出的分散 Line 重组为符合人类阅读顺序（从上到下，从左到右）的结构。
/// 特别针对化验单等表格结构进行优化，尝试恢复行列关系。
///
/// ## Algorithm
/// 1. **Flatten**: 提取所有 `OcrLine`。
/// 2. **Row Clustering**: 基于 Y 轴坐标和高度，将 Lines 聚类为逻辑行。
/// 3. **Column Sorting**: 在每一行内，基于 X 轴坐标对 Lines 进行排序。
/// 4. **Transformation**: 将排序后的 Lines 转换为 `SLMDataBlock`。
library;

import '../../../data/models/ocr_result.dart';
import '../../../data/models/slm/slm_data_block.dart';

class LayoutParser {
  /// 将 OCR 结果解析为有序的 SLM 数据块列表
  List<SLMDataBlock> parse(OcrResult ocrResult) {
    // 1. Flatten all lines from all pages
    final allLines = <_LineContext>[];
    for (final page in ocrResult.pages) {
      for (final block in page.blocks) {
        for (final line in block.lines) {
          allLines.add(_LineContext(line, page.pageNumber));
        }
      }
    }

    if (allLines.isEmpty) return [];

    // 2. Row Clustering
    // Sort by Y first to make clustering easier
    allLines.sort((a, b) => a.line.y.compareTo(b.line.y));

    final rows = <List<_LineContext>>[];

    for (final ctx in allLines) {
      bool added = false;

      // Try to add to an existing row
      // We iterate backwards to find the closest row (usually the last one)
      for (int i = rows.length - 1; i >= 0; i--) {
        final row = rows[i];
        final rowY = _calculateRowY(row);
        final rowH = _calculateRowHeight(row);

        // Threshold: 垂直中心距离小于行高的一半
        final centerDiff = (ctx.line.y + ctx.line.h / 2) - (rowY + rowH / 2);
        if (centerDiff.abs() < rowH * 0.5) {
          row.add(ctx);
          added = true;
          break;
        }
      }

      if (!added) {
        rows.add([ctx]);
      }
    }

    // 3. Column Sorting & 4. Transformation
    final result = <SLMDataBlock>[];

    for (final row in rows) {
      // Sort lines in row by X coordinate
      row.sort((a, b) => a.line.x.compareTo(b.line.x));

      for (final ctx in row) {
        result.add(
          SLMDataBlock(
            rawText: ctx.line.text,
            confidence: ctx.line.confidence,
            boundingBox: [ctx.line.x, ctx.line.y, ctx.line.w, ctx.line.h],
            // normalizedText and other fields will be filled by subsequent processors
          ),
        );
      }
    }

    return result;
  }

  double _calculateRowY(List<_LineContext> row) {
    if (row.isEmpty) return 0.0;
    double sum = 0.0;
    for (var ctx in row) {
      sum += ctx.line.y;
    }
    return sum / row.length;
  }

  double _calculateRowHeight(List<_LineContext> row) {
    if (row.isEmpty) return 0.0;
    double sum = 0.0;
    for (var ctx in row) {
      sum += ctx.line.h;
    }
    return sum / row.length;
  }
}

class _LineContext {
  final OcrLine line;
  final int pageNumber; // Reserved for multi-page support

  _LineContext(this.line, this.pageNumber);
}
