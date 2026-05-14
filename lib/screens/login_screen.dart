import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_config.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _routerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _saveAndLogin() async {
    if (_addressController.text.isEmpty || _userController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى ملء جميع الحقول الأساسية")),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('routerName', _routerNameController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('user', _userController.text);
    await prefs.setString('pass', _passController.text);
    await prefs.setBool('isLoggedIn', true);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار الأسد الذهبي
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 20),
              const Text(
                "تسجيل الدخول للراوتر",
                style: TextStyle(
                    color: AppConfig.primaryGold,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              _buildTextField(_routerNameController,
                  "اسم الراوتر (مثلاً: برج الفيصلية)", Icons.edit),
              const SizedBox(height: 15),
              _buildTextField(_addressController, "عنوان الـ IP أو الكلاود",
                  Icons.cloud_queue),
              const SizedBox(height: 15),
              _buildTextField(
                  _userController, "اسم المستخدم", Icons.person_outline),
              const SizedBox(height: 15),
              _buildTextField(
                  _passController, "كلمة المرور", Icons.lock_outline,
                  isPass: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveAndLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.primaryGold,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("دخول وحفظ البيانات",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPass = false}) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        prefixIcon: Icon(icon, color: AppConfig.primaryGold, size: 20),
        filled: true,
        fillColor: AppConfig.cardGrey,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: AppConfig.primaryGold, width: 1)),
      ),
    );
  }
}
