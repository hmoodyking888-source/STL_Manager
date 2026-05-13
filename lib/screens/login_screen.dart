import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              FadeInDown(
                child: Row(
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppTheme.primaryGold,
                          width: 1,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.crown,
                        color: AppTheme.primaryGold,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "STL_Manager",
                          style: TextStyle(
                            color: AppTheme.primaryGold,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "ربطك بالعالم بسرعة وثقة",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              FadeInLeft(
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: AppTheme.primaryGold,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: ipController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "عنوان الراوتر IP",
                  prefixIcon: Icon(Icons.router),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: userController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "اسم المستخدم",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "كلمة المرور",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await Future.delayed(
                    const Duration(seconds: 2),
                  );

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );

                  setState(() {
                    isLoading = false;
                  });
                },
                child: isLoading
                    ? SizedBox(
                        width: 22.w,
                        height: 22.h,
                        child: const CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("دخول"),
              ),
              SizedBox(height: 20.h),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.cloud,
                  color: AppTheme.primaryGold,
                ),
                label: const Text(
                  "إضافة كلاود",
                  style: TextStyle(
                    color: AppTheme.primaryGold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55.h),
                  side: const BorderSide(
                    color: AppTheme.primaryGold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  "STL_Manager v1.0.0",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
