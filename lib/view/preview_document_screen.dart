import 'package:drag_pdf/model/models.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/dialogs/custom_dialog.dart';

class PreviewDocumentScreen extends StatefulWidget {
  const PreviewDocumentScreen({super.key, required this.file});

  final FileRead file;

  @override
  State<PreviewDocumentScreen> createState() => _PreviewDocumentScreenState();
}

class _PreviewDocumentScreenState extends State<PreviewDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    final pdfPinchController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.file.getFile().path),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("DRAG PDF"),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await Share.shareXFiles(
                    [XFile(widget.file.getFile().path)],
                  ); // Document Generated With Drag PDF
                } catch (error) {
                  if (!context.mounted) return; // check "mounted" property
                  CustomDialog.showError(
                    context: context,
                    error: error,
                    titleLocalized: 'share_file_error_title',
                    subtitleLocalized: 'share_file_error_subtitle',
                    buttonTextLocalized: 'accept',
                  );
                }
              },
              icon: const Icon(Icons.share, color: Colors.white)),
        ],
      ),
      body: PdfViewPinch(
        controller: pdfPinchController,
      ),
    );
  }
}
