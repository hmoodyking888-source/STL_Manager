import 'package:flutter/material.dart';
import '../app_config.dart';
import '../services/auth_service.dart';
import 'hotspot_screen.dart';
import 'pppoe_screen.dart';
import 'infrastructure_screen.dart';
import 'telegram_activation_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpired = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSubscription();
  }

  void _checkSubscription() async {
    bool expired = await AuthService.checkSubscriptionStatus();
    if (mounted) {
      setState(() {
        isExpired = expired;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppConfig.backgroundBlack,
        body: Center(
            child: CircularProgressIndicator(color: AppConfig.primaryGold)),
      );
    }

    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppConfig.backgroundBlack,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: AppConfig.primaryGold, width: 1),
                shape: BoxShape.circle,
              ),
              child: const Text(AppConfig.appLogoText,
                  style: TextStyle(
                      color: AppConfig.primaryGold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            const Text(AppConfig.appBarTitle,
                style: TextStyle(
                    color: AppConfig.primaryGold,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 30),
            _buildGridMenu(context),
            const SizedBox(height: 60),
            _buildHiddenSignature(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppConfig.primaryGold.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stat("CPU", "12%"),
          _stat("TEMP", "41°C"),
          _stat("UPTIME", "4d"),
        ],
      ),
    );
  }

  static Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildGridMenu(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "الهوتسبوت", "icon": Icons.wifi, "page": const HotspotScreen()},
      {
        "title": "البرودباند",
        "icon": Icons.router,
        "page": const PPPoEScreen()
      },
      {
        "title": "قطع البث",
        "icon": Icons.bolt,
        "page": const InfrastructureScreen()
      },
      {
        "title": "التلجرام",
        "icon": Icons.telegram,
        "page": const TelegramActivationScreen()
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.1),
      itemCount: menuItems.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (c) => menuItems[index]['page'])),
        child: Container(
          decoration: BoxDecoration(
            color: AppConfig.cardGrey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(menuItems[index]['icon'],
                  color: AppConfig.primaryGold, size: 40),
              const SizedBox(height: 10),
              Text(menuItems[index]['title'],
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHiddenSignature() {
    return Opacity(
      opacity: 0.3, // شفافية عالية ليكون غير ملاحظ
      child: Column(
        children: [
          Text(AppConfig.appSignature,
              style: const TextStyle(color: Colors.grey, fontSize: 9)),
          const SizedBox(height: 2),
          Text(AppConfig.developerPhone,
              style: const TextStyle(color: Colors.grey, fontSize: 8)),
        ],
      ),
    );
  }
}
