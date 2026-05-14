import 'package:flutter/material.dart';

class AppConfig {
  // الهوية البصرية
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color cardGrey = Color(0xFF1A1A1A);

  // نصوص الواجهة (العناوين التي ظهرت فيها أخطاء)
  static const String appBarTitle = "STL_MANAGER";
  static const String developerName = "أحمد النعيمي";
  static const String developerPhone = "0995870655";
  static const String appSignature = "برمجة أحمد النعيمي";

  // إعدادات البوت والخدمات (التي كانت تسبب أخطاء في telegram_service)
  static const String telegramBotToken =
      "8661374323:AAHQefglt5JZCdBAy3yXgMwHtw3Pom0PwI8";
  static const String firebaseDbUrl =
      "https://your-project.firebaseio.com"; // استبدله برابط مشروعك
  static const int trialDays = 3;

  static const String appVersion = "1.2.1";
}
