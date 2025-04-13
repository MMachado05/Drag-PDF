import 'package:drag_pdf/core/theme.dart';
import 'package:drag_pdf/views/pdf_combiner_screen.dart';
import 'package:flutter/material.dart';

import 'core/l10n/app_localizations.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await DefaultFirebaseOptions.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag PDF',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const PdfCombinerScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
