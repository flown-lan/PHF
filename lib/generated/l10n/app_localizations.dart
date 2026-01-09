import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('id'),
    Locale('pt'),
    Locale('th'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'PaperHealth'**
  String get appTitle;

  /// General save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// General edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// General delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// General cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// General confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get common_confirm;

  /// No description provided for @lock_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter PIN to unlock'**
  String get lock_screen_title;

  /// No description provided for @lock_screen_error.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN, please try again'**
  String get lock_screen_error;

  /// No description provided for @lock_screen_biometric_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Unlock with biometrics'**
  String get lock_screen_biometric_tooltip;

  /// No description provided for @ingestion_title.
  ///
  /// In en, this message translates to:
  /// **'Preview & Processing'**
  String get ingestion_title;

  /// No description provided for @ingestion_empty_hint.
  ///
  /// In en, this message translates to:
  /// **'Please add medical record photos'**
  String get ingestion_empty_hint;

  /// No description provided for @ingestion_add_now.
  ///
  /// In en, this message translates to:
  /// **'Add Now'**
  String get ingestion_add_now;

  /// No description provided for @ingestion_ocr_hint.
  ///
  /// In en, this message translates to:
  /// **'Metadata will be recognized by background OCR after saving'**
  String get ingestion_ocr_hint;

  /// No description provided for @ingestion_submit_button.
  ///
  /// In en, this message translates to:
  /// **'Start Processing & Archive'**
  String get ingestion_submit_button;

  /// No description provided for @ingestion_grouped_report.
  ///
  /// In en, this message translates to:
  /// **'Mark as a multi-page report'**
  String get ingestion_grouped_report;

  /// No description provided for @ingestion_grouped_report_hint.
  ///
  /// In en, this message translates to:
  /// **'SLM will treat these images as a single continuous document'**
  String get ingestion_grouped_report_hint;

  /// No description provided for @review_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Verify Information'**
  String get review_edit_title;

  /// No description provided for @review_edit_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Archive'**
  String get review_edit_confirm;

  /// No description provided for @review_edit_basic_info.
  ///
  /// In en, this message translates to:
  /// **'Basic Info (Tap to Edit)'**
  String get review_edit_basic_info;

  /// No description provided for @review_edit_hospital_label.
  ///
  /// In en, this message translates to:
  /// **'Hospital/Institution'**
  String get review_edit_hospital_label;

  /// No description provided for @review_edit_date_label.
  ///
  /// In en, this message translates to:
  /// **'Visit Date'**
  String get review_edit_date_label;

  /// No description provided for @review_edit_confidence.
  ///
  /// In en, this message translates to:
  /// **'OCR Confidence'**
  String get review_edit_confidence;

  /// No description provided for @review_edit_page_indicator.
  ///
  /// In en, this message translates to:
  /// **'Image {current} / {total} (Please verify each page)'**
  String review_edit_page_indicator(int current, int total);

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_section_profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles & Categories'**
  String get settings_section_profiles;

  /// No description provided for @settings_manage_profiles.
  ///
  /// In en, this message translates to:
  /// **'Manage Profiles'**
  String get settings_manage_profiles;

  /// No description provided for @settings_manage_profiles_desc.
  ///
  /// In en, this message translates to:
  /// **'Add or edit personnel profiles'**
  String get settings_manage_profiles_desc;

  /// No description provided for @settings_tag_library.
  ///
  /// In en, this message translates to:
  /// **'Tag Library'**
  String get settings_tag_library;

  /// No description provided for @settings_tag_library_desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain medical record tags'**
  String get settings_tag_library_desc;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_language_desc.
  ///
  /// In en, this message translates to:
  /// **'Switch application display language'**
  String get settings_language_desc;

  /// No description provided for @settings_section_security.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get settings_section_security;

  /// No description provided for @settings_privacy_security.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settings_privacy_security;

  /// No description provided for @settings_privacy_security_desc.
  ///
  /// In en, this message translates to:
  /// **'Modify PIN and biometrics'**
  String get settings_privacy_security_desc;

  /// No description provided for @settings_backup_restore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get settings_backup_restore;

  /// No description provided for @settings_backup_restore_desc.
  ///
  /// In en, this message translates to:
  /// **'Export encrypted backup files'**
  String get settings_backup_restore_desc;

  /// No description provided for @settings_section_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settings_section_support;

  /// No description provided for @settings_feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settings_feedback;

  /// No description provided for @settings_feedback_desc.
  ///
  /// In en, this message translates to:
  /// **'Report issues or suggestions'**
  String get settings_feedback_desc;

  /// No description provided for @settings_section_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_section_about;

  /// No description provided for @settings_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_privacy_policy;

  /// No description provided for @settings_privacy_policy_desc.
  ///
  /// In en, this message translates to:
  /// **'View application privacy policy'**
  String get settings_privacy_policy_desc;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @detail_title.
  ///
  /// In en, this message translates to:
  /// **'Medical Record Details'**
  String get detail_title;

  /// No description provided for @detail_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get detail_edit_title;

  /// No description provided for @detail_retrigger_ocr.
  ///
  /// In en, this message translates to:
  /// **'Retrigger OCR'**
  String get detail_retrigger_ocr;

  /// No description provided for @detail_delete_page.
  ///
  /// In en, this message translates to:
  /// **'Delete Page'**
  String get detail_delete_page;

  /// No description provided for @detail_edit_page.
  ///
  /// In en, this message translates to:
  /// **'Edit Page'**
  String get detail_edit_page;

  /// No description provided for @detail_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get detail_save;

  /// No description provided for @detail_ocr_text.
  ///
  /// In en, this message translates to:
  /// **'View OCR Text'**
  String get detail_ocr_text;

  /// No description provided for @detail_cancel_edit.
  ///
  /// In en, this message translates to:
  /// **'Cancel Edit'**
  String get detail_cancel_edit;

  /// No description provided for @detail_ocr_result.
  ///
  /// In en, this message translates to:
  /// **'OCR Recognition Result'**
  String get detail_ocr_result;

  /// No description provided for @detail_view_raw.
  ///
  /// In en, this message translates to:
  /// **'View Raw'**
  String get detail_view_raw;

  /// No description provided for @detail_view_enhanced.
  ///
  /// In en, this message translates to:
  /// **'Smart Enhance'**
  String get detail_view_enhanced;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'hi',
    'id',
    'pt',
    'th',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'pt':
      return AppLocalizationsPt();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
