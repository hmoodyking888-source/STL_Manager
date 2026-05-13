import 'package:flutter/material.dart';
import 'app_config.dart';
import 'services/auth_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/lock_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التحقق من الصلاحية قبل تشغيل التطبيق
  bool isExpired = await AuthService.checkSubscriptionStatus();

  runApp(STNManagerApp(isExpired: isExpired));
}

class STNManagerApp extends StatelessWidget {
  final bool isExpired;
  const STNManagerApp({super.key, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STN Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppConfig.backgroundBlack,
        fontFamily: 'Cairo',
      ),
      // إذا انتهت الصلاحية يفتح صفحة القفل، وإذا لا يفتح الداشبورد
      home: isExpired ? const LockScreen() : const DashboardScreen(),
    );
  }
}
