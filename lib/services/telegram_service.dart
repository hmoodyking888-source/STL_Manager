import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_config.dart';

class TelegramService {
  static const String _baseUrl =
      "https://api.telegram.org/bot${AppConfig.telegramBotToken}";

  /// 1. دالة استخراج الـ Chat ID بناءً على رقم الهاتف من تحديثات البوت
  static Future<String?> getChatIdByPhone(String phoneNumber) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/getUpdates"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['ok'] == true) {
          List updates = data['result'];
          // البحث في الرسائل الواردة عن رقم الهاتف المطابق
          for (var update in updates) {
            if (update['message'] != null &&
                update['message']['contact'] != null) {
              String contactPhone =
                  update['message']['contact']['phone_number'];
              if (contactPhone.contains(phoneNumber)) {
                return update['message']['chat']['id'].toString();
              }
            }
          }
        }
      }
    } catch (e) {
      print("خطأ في جلب الـ Chat ID: $e");
    }
    return null;
  }

  /// 2. دالة تجهيز سكريبت الميكروتك (حقن توكن البوت والـ Chat ID الخاص بالعميل)
  static String generateMikroTikScript(String chatId) {
    return """
/system script add name="STN_Notification" source={
  :local botToken "${AppConfig.telegramBotToken}";
  :local chatId "$chatId";
  :local msg "تنبيه من راوتر العميل: تم تسجيل دخول جديد للشبكة";
  /tool fetch url="https://api.telegram.org/bot\$botToken/sendMessage?chat_id=\$chatId&text=\$msg" keep-result=no
}
/system scheduler add name="STN_Task" interval=1d on-event="STN_Notification"
    """;
  }

  /// 3. إرسال رسالة تأكيد نهائية عبر البوت للعميل
  static Future<bool> sendConfirmation(String chatId) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/sendMessage"),
        body: {
          "chat_id": chatId,
          "text":
              "✅ تم ربط تطبيق STN_Manager بنجاح مع راوتر ميكروتك الخاص بك.\nستصلك التنبيهات هنا فوراً.\n\nبرمجة: ${AppConfig.developerName}",
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
