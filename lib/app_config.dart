import 'package:flutter/material.dart';

class AppConfig {
  // ألوان الهوية البصرية (الأسود والذهبي)
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color cardGrey = Color(0xFF1A1A1A);

  // المسميات (تأكد من وجود كل هذه المسميات لأن الصفحات تطلبها)
  static const String appBarTitle = "STL_MANAGER";
  static const String appName = "STL_Manager";
  static const String developerName = "أحمد النعيمي";
  static const String developerPhone = "0995870655";
  static const String appSignature = "برمجة أحمد النعيمي";

  // إعدادات البوت والخدمات
  static const String telegramBotToken =
      "8661374323:AAHQefglt5JZCdBAy3yXgMwHtw3Pom0PwI8";
  static const String firebaseDbUrl =
      "https://stl-manager-default-rtdb.firebaseio.com";
  static const int trialDays = 3;

  static const String appVersion = "1.2.1";
}
