import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../app_config.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة متحركة فخمة (يتم وضع ملف الـ json في assets)
            Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_xl8v9qc8.json', // مثال لقفل متحرك ذهبي
              height: 250,
              repeat: true,
            ),

            const Text(
              "انتهت الفترة التجريبية",
              style: TextStyle(
                color: AppConfig.primaryGold,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "لقد استمتعت بـ 3 أيام من الإدارة الذكية. للاستمرار في استخدام النظام والحصول على كامل الميزات، يرجى تفعيل النسخة الأصلية.",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 40),

            // بطاقة التواصل مع المبرمج
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppConfig.cardGrey,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppConfig.primaryGold.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    "للتواصل والتفعيل",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppConfig.developerName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppConfig.developerPhone,
                    style: const TextStyle(
                        color: AppConfig.primaryGold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // زر مراسلة فورية
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.primaryGold,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // هنا نضع كود لفتح الواتساب مباشرة برقمك
                },
                icon: const Icon(Icons.send, color: Colors.black),
                label: const Text("تفعيل الآن",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
