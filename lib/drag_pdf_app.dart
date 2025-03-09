import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/localization/localization.dart';
import 'common/theme.dart';
import 'helper/app_router.dart';
import 'helper/app_session.dart';

class DragPdfApp extends StatelessWidget {
  const DragPdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeApp(),
      builder: (context, snapshot) {
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp.router(
            routerConfig: AppRouter.shared.getRouter(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            localizationsDelegates: const [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> initializeApp() async {
    await loadSecureInf();
    await prepareApp();
  }

  Future<void> loadSecureInf() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (error) {
      debugPrint(".env file is not loaded!!");
    }
  }

  Future<void> prepareApp() async {
    await AppSession.singleton.fileHelper.loadLocalPath();
    AppSession.singleton.fileHelper.emptyLocalDocumentFolder();
  }
}
