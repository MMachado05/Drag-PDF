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
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleAppBar => 'Drag PDF';

  @override
  String success_snackbar_single_file(Object path) {
    return 'File generated successfully: ($path)';
  }

  @override
  String success_snackbar_multiple_files(Object number) {
    return '($number) files generated successfully!';
  }

  @override
  String get output_files_title => 'OUTPUT FILES';

  @override
  String get input_files_title => 'INPUT FILES';

  @override
  String get restart_app_tooltip => 'Restart app';

  @override
  String get add_new_files_tooltip => 'Add new files';

  @override
  String get loading_size_message => 'Loading size...';

  @override
  String get unknown_size_message => 'Unknown Size';

  @override
  String file_removed_message(Object path) {
    return 'File ($path) removed.';
  }

  @override
  String get create_pdf_button => 'Create PDF';

  @override
  String get combine_pdfs_button => 'Combine PDFs';

  @override
  String get create_pdf_from_images_button => 'Create PDF from images';

  @override
  String get create_images_from_pdf_button => 'Create images from PDF';

  @override
  String get snackbar_app_restart => 'App restarted successfully!';

  @override
  String get snackbar_copy_output_to_clipboard => 'Output path copied to clipboard';

  @override
  String failed_open_file(Object error) {
    return 'Failed to open file. Error: ($error).';
  }

  @override
  String get select_files_title_dialog => 'Select Files';

  @override
  String get select_files_content_dialog => 'Choose how you want to add the files';

  @override
  String get select_from_device_button => 'Select from Device';

  @override
  String get select_from_scanner_button => 'Select from Scanner';

  @override
  String get cancel_button => 'Cancel';

  @override
  String get select_file_type_title_dialog => 'What type of file do you want to load?';

  @override
  String get images_button => 'Images';

  @override
  String get documents_button => 'Documents';

  @override
  String get not_enough_files_message => 'You need at least 2 PDF files to combine them';
}
