import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

extension DialogExtension on BuildContext {
  Future<void> showFilePickerDialog(
    Function(FilePickerResult?) onFilesPicked,
  ) async {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Files"),
          content: Text("Choose how you want to add the files"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                context.showFilePickerWithTypeFileDialog(onFilesPicked);
              },
              child: Text("Select from Device"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                List<PlatformFile>? scannedDocument = await scanDocument();
                if (scannedDocument != null) {
                  FilePickerResult result = FilePickerResult(scannedDocument);
                  onFilesPicked(result);
                }
              },
              child: Text("Scan Document"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showFilePickerWithTypeFileDialog(
    Function(FilePickerResult?) onFilesPicked,
  ) async {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text("What type of file do you want to load?"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: true,
                );
                onFilesPicked(result);
              },
              child: Text("Images"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                  allowMultiple: true,
                );
                onFilesPicked(result);
              },
              child: Text("Documents"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<List<PlatformFile>?> scanDocument() async {
    final scannedImage = await CunningDocumentScanner.getPictures();

    if (scannedImage != null) {
      return scannedImage
          .map(
            (element) => PlatformFile(
              path: element,
              name: element.split('/').last,
              size: File(element).lengthSync(),
            ),
          )
          .toList();
    }
    return null;
  }
}
