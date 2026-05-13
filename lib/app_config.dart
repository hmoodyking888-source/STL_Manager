import 'package:flutter/material.dart';

class AppConfig {
  // 1. الهوية الأساسية للتطبيق
  static const String appBarTitle = "STL_MANAGER";
  static const String appLogoText = "S"; // حرف S الذهبي

  // 2. معلومات المبرمج (حقوق الملكية - مكان غير بارز)
  static const String developerName = "أحمد النعيمي";
  static const String developerPhone = "0995870655";
  static const String appSignature = "Developed by: $developerName";

  // 3. إعدادات التلجرام وفيرباس
  static const String telegramBotToken =
      "8661374323:AAHQefglt5JZCdBAy3yXgMwHtw3Pom0PwI8";
  static const String firebaseDbUrl =
      "https://stn-manager-f6333-default-rtdb.firebaseio.com/";

  // 4. ألوان الهوية البصرية
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color backgroundBlack = Color(0xFF0D0D0D);
  static const Color cardGrey = Color(0xFF1A1A1A);

  static const int trialDays = 3;
}
