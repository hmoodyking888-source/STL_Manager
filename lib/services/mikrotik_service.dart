import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MikroTikService {
  // دالة لجلب البيانات المحفوظة من شاشة الدخول
  static Future<Map<String, String>> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "address": prefs.getString('address') ?? "",
      "user": prefs.getString('user') ?? "",
      "pass": prefs.getString('pass') ?? "",
    };
  }

  // دالة جلب موارد النظام
  static Future<Map<String, String>> getSystemResources() async {
    try {
      // حالياً نعيد قيم افتراضية حتى نتم الربط الفعلي بـ API الراوتر
      return {
        "cpu": "12%",
        "temp": "41°C",
        "uptime": "4d 02h",
        "voltage": "23.5V"
      };
    } catch (e) {
      return {"cpu": "0%", "temp": "0", "uptime": "Error"};
    }
  }
}
