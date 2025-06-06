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

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get titleAppBar => 'Drag PDF';

  @override
  String success_snackbar_single_file(Object path) {
    return 'Fichero generado con éxito: ($path)';
  }

  @override
  String success_snackbar_multiple_files(Object number) {
    return '¡($number) ficheros generados con éxito!';
  }

  @override
  String get output_files_title => 'Ficheros de Salida';

  @override
  String get input_files_title => 'Ficheros de Entrada';

  @override
  String get restart_app_tooltip => 'Reiniciar app';

  @override
  String get add_new_files_tooltip => 'Añadir nuevos ficheros';

  @override
  String get loading_size_message => 'Cargando tamaño...';

  @override
  String get unknown_size_message => 'Tamaño desconocido';

  @override
  String file_removed_message(Object path) {
    return 'Fichero ($path) eliminado.';
  }

  @override
  String get create_pdf_button => 'Crear PDF';

  @override
  String get combine_pdfs_button => 'Combinar PDFs';

  @override
  String get create_pdf_from_images_button => 'Crear PDF desde imágenes';

  @override
  String get create_images_from_pdf_button => 'Crear imágenes desde PDF';

  @override
  String get snackbar_app_restart => 'App reiniciada con éxito!';

  @override
  String get snackbar_copy_output_to_clipboard => 'Ruta de salida copiada al portapapeles';

  @override
  String failed_open_file(Object error) {
    return 'Falló al abrir el fichero. Error: ($error).';
  }

  @override
  String get select_files_title_dialog => 'Selecciona ficheros';

  @override
  String get select_files_content_dialog => 'Elige cómo quieres añadir los ficheros';

  @override
  String get select_from_device_button => 'Seleccionar desde el dispositivo';

  @override
  String get select_from_scanner_button => 'Seleccionar desde el escáner';

  @override
  String get cancel_button => 'Cancelar';

  @override
  String get select_file_type_title_dialog => '¿Qué tipo de fichero quieres cargar?';

  @override
  String get images_button => 'Imágenes';

  @override
  String get documents_button => 'Documentos';

  @override
  String get not_enough_files_message => 'Necesitas al menos 2 ficheros PDF para combinarlos.';
}
