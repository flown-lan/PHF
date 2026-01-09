// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '纸上健康';

  @override
  String get common_save => '保存';

  @override
  String get common_edit => '编辑';

  @override
  String get common_delete => '删除';

  @override
  String get common_cancel => '取消';

  @override
  String get common_confirm => '确认';

  @override
  String get lock_screen_title => '请输入 PIN 码解锁';

  @override
  String get lock_screen_error => 'PIN 码错误，请重新输入';

  @override
  String get lock_screen_biometric_tooltip => '使用生物识别解锁';

  @override
  String get ingestion_title => '预览与处理';

  @override
  String get ingestion_empty_hint => '请添加病历照片';

  @override
  String get ingestion_add_now => '立即添加';

  @override
  String get ingestion_ocr_hint => '元数据将在保存后由背景 OCR 自动识别';

  @override
  String get ingestion_submit_button => '开始处理并归档';

  @override
  String get ingestion_grouped_report => '标记为同一份跨页报告';

  @override
  String get ingestion_grouped_report_hint => '开启后，SLM 将把这些图片视为一个连续的完整报告进行分析';

  @override
  String get review_edit_title => '校对信息';

  @override
  String get review_edit_confirm => '确认归档';

  @override
  String get review_edit_basic_info => '基本信息 (可点击修改)';

  @override
  String get review_edit_hospital_label => '医院/机构名称';

  @override
  String get review_edit_date_label => '就诊日期';

  @override
  String get review_edit_confidence => 'OCR 置信度';

  @override
  String review_edit_page_indicator(int current, int total) {
    return '图片 $current / $total (请核对每页信息)';
  }

  @override
  String get settings_title => '设置';

  @override
  String get settings_section_profiles => '档案与分类';

  @override
  String get settings_manage_profiles => '管理档案';

  @override
  String get settings_manage_profiles_desc => '添加或编辑人员档案';

  @override
  String get settings_tag_library => '标签库管理';

  @override
  String get settings_tag_library_desc => '维护病历分类标签';

  @override
  String get settings_language => '语言设置';

  @override
  String get settings_language_desc => '切换应用显示语言';

  @override
  String get settings_section_security => '数据安全';

  @override
  String get settings_privacy_security => '隐私与安全';

  @override
  String get settings_privacy_security_desc => '修改 PIN 码及生物识别';

  @override
  String get settings_backup_restore => '备份与恢复';

  @override
  String get settings_backup_restore_desc => '导出加密备份文件';

  @override
  String get settings_section_support => '帮助与支持';

  @override
  String get settings_feedback => '问题反馈';

  @override
  String get settings_feedback_desc => '报告问题或提交建议';

  @override
  String get settings_section_about => '关于';

  @override
  String get settings_privacy_policy => '隐私政策';

  @override
  String get settings_privacy_policy_desc => '查看应用隐私保护声明';

  @override
  String get settings_version => '版本信息';

  @override
  String get detail_title => '病历详情';

  @override
  String get detail_edit_title => '编辑详情';

  @override
  String get detail_retrigger_ocr => '重新识别';

  @override
  String get detail_delete_page => '删除此页';

  @override
  String get detail_edit_page => '编辑此页';

  @override
  String get detail_save => '保存';

  @override
  String get detail_ocr_text => '查看识别文本';

  @override
  String get detail_cancel_edit => '取消编辑';

  @override
  String get detail_ocr_result => 'OCR 识别结果';

  @override
  String get detail_view_raw => '查看原文';

  @override
  String get detail_view_enhanced => '智能增强';
}
