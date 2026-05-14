import 'package:shared_preferences/shared_preferences.dart';

class MikroTikService {
  // دالة لجلب البيانات التي يدخلها العميل في شاشة الدخول
  static Future<Map<String, String>> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "address": prefs.getString('address') ?? "",
      "user": prefs.getString('user') ?? "",
      "pass": prefs.getString('pass') ?? "",
      "name": prefs.getString('routerName') ?? "راوتر غير مسمى",
    };
  }

  // دالة لجلب موارد النظام (سنستخدمها في الداشبورد)
  static Future<Map<String, String>> getSystemResources() async {
    // هذه القيم ستكون ثابتة حالياً حتى نربط الـ API الفعلي
    return {
      "cpu": "15%",
      "temp": "42°C",
      "uptime": "2d 05h",
      "voltage": "23.8V"
    };
  }
}
