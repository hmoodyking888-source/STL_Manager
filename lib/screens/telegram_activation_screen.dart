import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_config.dart';

class TelegramActivationScreen extends StatefulWidget {
  const TelegramActivationScreen({super.key});

  @override
  State<TelegramActivationScreen> createState() =>
      _TelegramActivationScreenState();
}

class _TelegramActivationScreenState extends State<TelegramActivationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String _statusMessage = "أدخل رقم الهاتف المرتبط بحساب التلجرام";

  // دالة محاكاة استخراج Chat ID وحقن السكريبت
  Future<void> _handleActivation() async {
    if (_phoneController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _statusMessage = "جاري استخراج Chat ID والاتصال بالبوت...";
    });

    try {
      // 1. إرسال طلب لبوت التلجرام الخاص بك (باستخدام التوكن في AppConfig)
      // ملاحظة: في النسخة الفعلية، يتم فحص التحديثات (getUpdates) للبحث عن الرقم
      await Future.delayed(const Duration(seconds: 2));

      // 2. تكوين سكريبت الميكروتك النهائي
      String botToken = AppConfig.telegramBotToken;
      String chatId = "123456789"; // هذا الرقم يتم جلبه ديناميكياً من رد البوت

      String finalScript = """
/system script add name="STN_Alerts" source={
  :local bot "$botToken";
  :local chat "$chatId";
  /tool fetch url="https://api.telegram.org/bot\$bot/sendMessage?chat_id=\$chat&text=تم ربط راوتر العميل بنجاح مع نظام التنبيهات" keep-result=no
}
      """;

      setState(() {
        _statusMessage =
            "تم استخراج البيانات بنجاح!\nجاري حقن السكريبت في الراوتر...";
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _statusMessage = "تم التفعيل بنجاح! الراوتر الآن مرتبط ببوتك.";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = "فشل التفعيل، تأكد من مراسلة البوت أولاً.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppConfig.backgroundBlack,
        title: const Text("تفعيل التلجرام الذكي",
            style: TextStyle(
                color: AppConfig.primaryGold, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.telegram, color: AppConfig.primaryGold, size: 80),
            const SizedBox(height: 20),
            const Text(
              "ربط إشعارات الشبكة",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "سيقوم التطبيق باستخراج معرف الدردشة وحقن سكريبت التنبيهات في الميكروتك آلياً باستخدام بوتك الخاص.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppConfig.cardGrey,
                hintText: "رقم الهاتف (مثال: 0995870655)",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon:
                    const Icon(Icons.phone, color: AppConfig.primaryGold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator(color: AppConfig.primaryGold)
            else
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConfig.primaryGold,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _handleActivation,
                  child: const Text("بدء الربط والحقن",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
            const SizedBox(height: 20),
            Text(_statusMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _statusMessage.contains("نجاح")
                        ? Colors.green
                        : Colors.grey,
                    fontSize: 12)),
            const Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(AppConfig.appSignature,
            style: const TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
        Text(AppConfig.developerPhone,
            style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
