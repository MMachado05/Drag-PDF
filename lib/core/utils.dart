import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:platform_detail/platform_detail.dart';

class Utils {
  static bool checkEnvFile() {
    String platform = PlatformDetail.currentPlatform.name.toUpperCase();
    final apiKey = dotenv.env['${platform}_API_KEY'];
    final appId = dotenv.env['${platform}_APP_ID'];
    final messagingSenderId = dotenv.env['${platform}_MESSAGING_SENDER_ID'];
    final projectId = dotenv.env['${platform}_PROJECT_ID'];

    return [
      apiKey,
      appId,
      messagingSenderId,
      projectId,
    ].every((e) => e?.isNotEmpty == true);
  }
}
