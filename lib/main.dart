import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التحقق من وجود بيانات دخول محفوظة
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(STLManagerApp(isLoggedIn: isLoggedIn));
}

class STLManagerApp extends StatelessWidget {
  final bool isLoggedIn;
  const STLManagerApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // تم استبدال appName بـ appBarTitle ليطابق ملف AppConfig الجديد
      title: "STL_Manager",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Cairo',
      ),
      home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
