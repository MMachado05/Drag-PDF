import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<void> showFilePickerDialog(BuildContext context, Function(FilePickerResult?) onFilesPicked) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select Files"),
        content: Text("Choose how you want to add the files"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              showFilePickerWithTypeFileDialog(context, onFilesPicked);
            },
            child: Text(style: TextStyle(color: Colors.white),"Select from Device"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              List<PlatformFile>? scannedDocument = await scanDocument(context);
              if (scannedDocument != null) {
                FilePickerResult result = FilePickerResult(scannedDocument);
                onFilesPicked(result);
              }
            },
            child: Text(style: TextStyle(color: Colors.white),"Scan Document"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(style: TextStyle(color: Colors.white),"Cancel"),
          ),
        ],
      );
    },
  );
}
Future<void> showFilePickerWithTypeFileDialog(BuildContext context, Function(FilePickerResult?) onFilesPicked) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("What type of file do you want to upload?"),
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
            child: Text(style: TextStyle(color: Colors.white),"Select images"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: true,
              );
              onFilesPicked(result);
            },
            child: Text(style: TextStyle(color: Colors.white),"Select documents"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
Future<List<PlatformFile>?> scanDocument(BuildContext context) async {
  final scannedImage = await CunningDocumentScanner.getPictures();

  if (scannedImage != null) {
    return scannedImage.map((element) => PlatformFile(
      path: element,
      name: element.split('/').last,
      size: File(element).lengthSync(),
    )).toList();
  }
  return null;
}