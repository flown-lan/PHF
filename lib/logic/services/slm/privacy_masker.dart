/// # Privacy Masker
///
/// ## Description
/// 本地隐私脱敏服务。在数据发送给 SLM 之前，识别并掩盖 PII (Personally Identifiable Information)。
///
/// ## Rules
/// - **Mobile**: `1[3-9]\d{9}` -> `1**********`
/// - **ID Card**: `\d{15}(\d|X|x)` -> `******************`
/// - **Names**: (Future Work) 基于 NER 或规则库识别姓名。
library;

class PrivacyMasker {
  static final _mobileRegex = RegExp(r'(1[3-9]\d{9})');
  // 简单的身份证正则，涵盖 15 位和 18 位
  static final _idCardRegex = RegExp(r'(\d{15}(\d|X|x)?|\d{17}(\d|X|x))');

  String mask(String text) {
    String masked = text;

    // Mask Mobile: 保留首位，其余星号 (简单起见，全部掩盖也行，这里保留一位)
    masked = masked.replaceAllMapped(_mobileRegex, (match) {
      return '1**********';
    });

    // Mask ID Card
    masked = masked.replaceAllMapped(_idCardRegex, (match) {
      return '*' * match.group(0)!.length;
    });

    return masked;
  }
}
