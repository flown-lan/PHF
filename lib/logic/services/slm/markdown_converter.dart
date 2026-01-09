/// # Markdown Converter
///
/// ## Description
/// 将结构化的 SLM 数据块序列化为 Markdown 格式，优化 SLM 的输入 Token。
library;

import '../../../data/models/slm/slm_data_block.dart';

class MarkdownConverter {
  String convert(List<SLMDataBlock> blocks) {
    if (blocks.isEmpty) return '';

    final buffer = StringBuffer();
    double? lastY;

    // 假设 blocks 已经按行排序 (LayoutParser 保证了这点)
    for (final block in blocks) {
      if (lastY != null) {
        // 判断是否换行：如果 Y 坐标差异过大
        // 这里需要一个参考高度，假设 block.h 大致相同
        final diff = (block.boundingBox[1] - lastY).abs();
        final h = block.boundingBox[3];

        // 简单阈值：半个高度
        if (diff > h * 0.5) {
          buffer.writeln();
        } else {
          buffer.write(' | '); // 列分隔符
        }
      }

      // 优先使用 normalizedText，没有则用 rawText
      buffer.write(block.normalizedText ?? block.rawText);
      lastY = block.boundingBox[1];
    }

    return buffer.toString();
  }
}
