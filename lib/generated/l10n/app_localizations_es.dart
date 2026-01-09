// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PaperHealth';

  @override
  String get common_save => 'Guardar';

  @override
  String get common_edit => 'Editar';

  @override
  String get common_delete => 'Eliminar';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_confirm => 'Confirmar';

  @override
  String get lock_screen_title => 'Por favor, ingrese el PIN para desbloquear';

  @override
  String get lock_screen_error => 'PIN incorrecto, por favor intente de nuevo';

  @override
  String get lock_screen_biometric_tooltip => 'Desbloquear con biometría';

  @override
  String get ingestion_title => 'Vista previa y procesamiento';

  @override
  String get ingestion_empty_hint =>
      'Por favor, añada fotos de registros médicos';

  @override
  String get ingestion_add_now => 'Añadir ahora';

  @override
  String get ingestion_ocr_hint =>
      'Los metadatos serán reconocidos por el OCR en segundo plano después de guardar';

  @override
  String get ingestion_submit_button => 'Iniciar procesamiento y archivar';

  @override
  String get ingestion_grouped_report =>
      'Marcar como informe de varias páginas';

  @override
  String get ingestion_grouped_report_hint =>
      'SLM tratará estas imágenes como un único documento continuo';

  @override
  String get review_edit_title => 'Verificar información';

  @override
  String get review_edit_confirm => 'Confirmar y archivar';

  @override
  String get review_edit_basic_info => 'Información básica (Toque para editar)';

  @override
  String get review_edit_hospital_label => 'Hospital/Institución';

  @override
  String get review_edit_date_label => 'Fecha de visita';

  @override
  String get review_edit_confidence => 'Confianza de OCR';

  @override
  String review_edit_page_indicator(int current, int total) {
    return 'Imagen $current / $total (Por favor, verifique cada página)';
  }

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_section_profiles => 'Profiles & Categories';

  @override
  String get settings_manage_profiles => 'Manage Profiles';

  @override
  String get settings_manage_profiles_desc => 'Add or edit personnel profiles';

  @override
  String get settings_tag_library => 'Tag Library';

  @override
  String get settings_tag_library_desc => 'Maintain medical record tags';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_language_desc => 'Switch application display language';

  @override
  String get settings_section_security => 'Data Security';

  @override
  String get settings_privacy_security => 'Privacy & Security';

  @override
  String get settings_privacy_security_desc => 'Modify PIN and biometrics';

  @override
  String get settings_backup_restore => 'Backup & Restore';

  @override
  String get settings_backup_restore_desc => 'Export encrypted backup files';

  @override
  String get settings_section_support => 'Help & Support';

  @override
  String get settings_feedback => 'Feedback';

  @override
  String get settings_feedback_desc => 'Report issues or suggestions';

  @override
  String get settings_section_about => 'About';

  @override
  String get settings_privacy_policy => 'Privacy Policy';

  @override
  String get settings_privacy_policy_desc => 'View application privacy policy';

  @override
  String get settings_version => 'Version';

  @override
  String get detail_title => 'Medical Record Details';

  @override
  String get detail_edit_title => 'Edit Details';

  @override
  String get detail_retrigger_ocr => 'Retrigger OCR';

  @override
  String get detail_delete_page => 'Delete Page';

  @override
  String get detail_edit_page => 'Edit Page';

  @override
  String get detail_save => 'Save';

  @override
  String get detail_ocr_text => 'View OCR Text';

  @override
  String get detail_cancel_edit => 'Cancel Edit';

  @override
  String get detail_ocr_result => 'OCR Recognition Result';

  @override
  String get detail_view_raw => 'View Raw';

  @override
  String get detail_view_enhanced => 'Smart Enhance';
}
