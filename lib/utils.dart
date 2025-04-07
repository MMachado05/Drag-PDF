import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String getPlatformName() {
  if (kIsWeb) return 'Web';
  if (Platform.isAndroid) return 'Android';
  if (Platform.isIOS) return 'iOS';
  if (Platform.isMacOS) return 'macOS';
  if (Platform.isWindows) return 'Windows';
  if (Platform.isLinux) return 'Linux';
  return 'Unknown';
}
bool checkEnvFile(){
  String platform = getPlatformName().toUpperCase();
  final apiKey = dotenv.env['${platform}_API_KEY'];
  final appId = dotenv.env['${platform}_APP_ID'];
  final messagingSenderId = dotenv.env['${platform}_MESSAGING_SENDER_ID'];
  final projectId = dotenv.env['${platform}_PROJECT_ID'];

  return [apiKey, appId, messagingSenderId, projectId].every((e) => e?.isNotEmpty == true);
}