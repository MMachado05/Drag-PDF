/*
Copyright 2022-2025 Victor Carreras

This file is part of Drag-PDF.

Drag-PDF is free software: you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any
later version.

Drag-PDF is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE. See the GNU Lesser General Public License for more
details.

You should have received a copy of the GNU Lesser General
Public License along with Drag-PDF. If not, see
<https://www.gnu.org/licenses/>.
*/
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @titleAppBar.
  ///
  /// In en, this message translates to:
  /// **'Drag PDF'**
  String get titleAppBar;

  /// No description provided for @success_snackbar_single_file.
  ///
  /// In en, this message translates to:
  /// **'File generated successfully: ({path})'**
  String success_snackbar_single_file(Object path);

  /// No description provided for @success_snackbar_multiple_files.
  ///
  /// In en, this message translates to:
  /// **'({number}) files generated successfully!'**
  String success_snackbar_multiple_files(Object number);

  /// No description provided for @output_files_title.
  ///
  /// In en, this message translates to:
  /// **'OUTPUT FILES'**
  String get output_files_title;

  /// No description provided for @input_files_title.
  ///
  /// In en, this message translates to:
  /// **'INPUT FILES'**
  String get input_files_title;

  /// No description provided for @restart_app_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Restart app'**
  String get restart_app_tooltip;

  /// No description provided for @add_new_files_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add new files'**
  String get add_new_files_tooltip;

  /// No description provided for @loading_size_message.
  ///
  /// In en, this message translates to:
  /// **'Loading size...'**
  String get loading_size_message;

  /// No description provided for @unknown_size_message.
  ///
  /// In en, this message translates to:
  /// **'Unknown Size'**
  String get unknown_size_message;

  /// No description provided for @file_removed_message.
  ///
  /// In en, this message translates to:
  /// **'File ({path}) removed.'**
  String file_removed_message(Object path);

  /// No description provided for @create_pdf_button.
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get create_pdf_button;

  /// No description provided for @combine_pdfs_button.
  ///
  /// In en, this message translates to:
  /// **'Combine PDFs'**
  String get combine_pdfs_button;

  /// No description provided for @create_pdf_from_images_button.
  ///
  /// In en, this message translates to:
  /// **'Create PDF from images'**
  String get create_pdf_from_images_button;

  /// No description provided for @create_images_from_pdf_button.
  ///
  /// In en, this message translates to:
  /// **'Create images from PDF'**
  String get create_images_from_pdf_button;

  /// No description provided for @snackbar_app_restart.
  ///
  /// In en, this message translates to:
  /// **'App restarted successfully!'**
  String get snackbar_app_restart;

  /// No description provided for @snackbar_copy_output_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Output path copied to clipboard'**
  String get snackbar_copy_output_to_clipboard;

  /// No description provided for @failed_open_file.
  ///
  /// In en, this message translates to:
  /// **'Failed to open file. Error: ({error}).'**
  String failed_open_file(Object error);

  /// No description provided for @select_files_title_dialog.
  ///
  /// In en, this message translates to:
  /// **'Select Files'**
  String get select_files_title_dialog;

  /// No description provided for @select_files_content_dialog.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to add the files'**
  String get select_files_content_dialog;

  /// No description provided for @select_from_device_button.
  ///
  /// In en, this message translates to:
  /// **'Select from Device'**
  String get select_from_device_button;

  /// No description provided for @select_from_scanner_button.
  ///
  /// In en, this message translates to:
  /// **'Select from Scanner'**
  String get select_from_scanner_button;

  /// No description provided for @cancel_button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// No description provided for @select_file_type_title_dialog.
  ///
  /// In en, this message translates to:
  /// **'What type of file do you want to load?'**
  String get select_file_type_title_dialog;

  /// No description provided for @images_button.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images_button;

  /// No description provided for @documents_button.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents_button;

  /// No description provided for @not_enough_files_message.
  ///
  /// In en, this message translates to:
  /// **'You need at least 2 PDF files to combine them'**
  String get not_enough_files_message;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
