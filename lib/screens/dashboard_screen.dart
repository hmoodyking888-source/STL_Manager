import 'package:flutter/material.dart';
import '../app_config.dart';
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
  // متغيرات حالة النظام (سيتم ربطها بـ MikroTikService لاحقاً)
  String cpuLoad = "12%";
  String temperature = "41°C";
  String uptime = "4d 02h";
  String currentSpeed = "152.4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            _buildMainMonitor(), // شاشة المراقبة الذهبية
            const SizedBox(height: 30),
            _buildActionGrid(context), // شبكة الأزرار
            const SizedBox(height: 50),
            _buildHiddenSignature(), // توقيعك الشخصي
          ],
        ),
      ),
    );
  }

  // رأس الصفحة (AppBar) بتصميم عصري
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppConfig.primaryGold, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield,
                    color: AppConfig.primaryGold, size: 14),
              ),
              const SizedBox(width: 8),
              const Text(
                AppConfig.appBarTitle,
                style: TextStyle(
                  color: AppConfig.primaryGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Text(
            "ربطك بالعالم بسرعة وثقة",
            style: TextStyle(color: Colors.white38, fontSize: 10),
          ),
        ],
      ),
    );
  }

  // كرت المراقبة الرئيسي (Dashboard Header)
  Widget _buildMainMonitor() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: AppConfig.primaryGold.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppConfig.primaryGold.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          // العدادات العلوية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmallStat("CPU", cpuLoad, Icons.memory),
              _buildSmallStat("TEMP", temperature, Icons.thermostat),
              _buildSmallStat("UPTIME", uptime, Icons.timer),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.white10, thickness: 1),
          ),
          // منطقة السرعة الحالية (Speedometer Style)
          Column(
            children: [
              Text(
                currentSpeed,
                style: const TextStyle(
                  color: AppConfig.primaryGold,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const Text(
                "Mbps السرعة الحالية",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 10),
              const Text(
                "RB1100AHx4 Dude Edition",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppConfig.primaryGold, size: 18),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        Text(label, style: const TextStyle(color: Colors.white30, fontSize: 9)),
      ],
    );
  }

  // شبكة الأزرار (Grid Menu)
  Widget _buildActionGrid(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "name": "الهوتسبوت",
        "icon": Icons.wifi_tethering,
        "screen": const HotspotScreen()
      },
      {
        "name": "البرودباند",
        "icon": Icons.settings_input_component,
        "screen": const PPPoEScreen()
      },
      {
        "name": "قطع البث",
        "icon": Icons.cell_tower,
        "screen": const InfrastructureScreen()
      },
      {
        "name": "التلجرام",
        "icon": Icons.send_rounded,
        "screen": const TelegramActivationScreen()
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (c) => items[index]['screen'])),
          child: Container(
            decoration: BoxDecoration(
              color: AppConfig.cardGrey,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(items[index]['icon'],
                    color: AppConfig.primaryGold, size: 36),
                const SizedBox(height: 12),
                Text(
                  items[index]['name'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // توقيع المبرمج المخفي
  Widget _buildHiddenSignature() {
    return Opacity(
      opacity: 0.2,
      child: Column(
        children: [
          Text(
            AppConfig.appSignature,
            style: const TextStyle(color: Colors.white, fontSize: 9),
          ),
          const SizedBox(height: 4),
          Text(
            AppConfig.developerPhone,
            style: const TextStyle(color: Colors.white, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
