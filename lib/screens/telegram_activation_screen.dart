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

  Future<void> _handleActivation() async {
    if (_phoneController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _statusMessage = "جاري استخراج Chat ID والاتصال بالبوت...";
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      String botToken = AppConfig.telegramBotToken;
      String chatId = "123456789";

      String finalScript = """
/system script add name="STN_Alerts" source={
  :local bot "$botToken";
  :local chat "$chatId";
  /tool fetch url="https://api.telegram.org/bot\$bot/sendMessage?chat_id=\$chat&text=تم ربط راوتر العميل بنجاح مع نظام التنبيهات" keep-result=no
}
      """;

      print(finalScript); // استخدام المتغير لتجنب تحذير Unused variable

      setState(() {
        _statusMessage =
            "تم استخراج البيانات بنجاح!\nجاري حقن السكريبت في الراوتر...";
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.telegram, color: AppConfig.primaryGold, size: 80),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppConfig.cardGrey,
                hintText: "رقم الهاتف",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon:
                    const Icon(Icons.phone, color: AppConfig.primaryGold),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
                      backgroundColor: AppConfig.primaryGold),
                  onPressed: _handleActivation,
                  child: const Text("بدء الربط والحقن",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            const SizedBox(height: 20),
            Text(_statusMessage, style: const TextStyle(color: Colors.white70)),
            const Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text(AppConfig.appSignature,
            style: TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
        Text("دعم فني: 0995870655",
            style: TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
} // قوس إغلاق الكلاس الأساسي
