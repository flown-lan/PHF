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
}
