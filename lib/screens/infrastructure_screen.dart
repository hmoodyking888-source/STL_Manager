import 'package:flutter/material.dart';
import '../app_config.dart';

class InfrastructureScreen extends StatefulWidget {
  const InfrastructureScreen({super.key});

  @override
  State<InfrastructureScreen> createState() => _InfrastructureScreenState();
}

class _InfrastructureScreenState extends State<InfrastructureScreen> {
  // قائمة تجريبية للأجهزة - سيتم ربطها بـ API الميكروتك لاحقاً
  final List<Map<String, String>> devices = [
    {
      "name": "برج الشمال - الرئيسي",
      "ip": "192.168.88.10",
      "type": "Access Point",
      "status": "متصل"
    },
    {
      "name": "مشترك - فيلا 05",
      "ip": "192.168.88.21",
      "type": "Station",
      "status": "متصل"
    },
    {
      "name": "قطعة البث الشرقية",
      "ip": "192.168.88.15",
      "type": "Access Point",
      "status": "قطع اتصال"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppConfig.backgroundBlack,
        elevation: 0,
        title: const Text("إدارة البنية التحتية",
            style: TextStyle(
                color: AppConfig.primaryGold, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppConfig.primaryGold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildHeaderInfo(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: devices.length,
              itemBuilder: (context, index) => _buildDeviceCard(devices[index]),
            ),
          ),
          _buildFooterRights(),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppConfig.primaryGold.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _headerStat("الأجهزة", "${devices.length}"),
          _headerStat("نشط", "2"),
          _headerStat("متوقف", "1"),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: AppConfig.primaryGold,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildDeviceCard(Map<String, String> device) {
    bool isOnline = device['status'] == "متصل";
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: isOnline
                ? Colors.green.withValues(alpha: 0.2)
                : Colors.red.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            device['type'] == "Access Point"
                ? Icons.settings_input_antenna
                : Icons.router,
            color: isOnline ? AppConfig.primaryGold : Colors.grey,
            size: 30,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device['name']!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(device['ip']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(device['type']!,
                    style: TextStyle(
                        color: AppConfig.primaryGold.withValues(alpha: 0.7),
                        fontSize: 10)),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_note, color: AppConfig.primaryGold),
                onPressed: () => _showEditNameDialog(device['name']!),
              ),
              Text(device['status']!,
                  style: TextStyle(
                      color: isOnline ? Colors.green : Colors.red,
                      fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditNameDialog(String currentName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppConfig.cardGrey,
        title: const Text("تعديل مسمى القطعة",
            style: TextStyle(color: AppConfig.primaryGold)),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: currentName,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppConfig.primaryGold)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey))),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("حفظ",
                  style: TextStyle(color: AppConfig.primaryGold))),
        ],
      ),
    );
  }

  Widget _buildFooterRights() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text(AppConfig.appSignature,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          Text(AppConfig.developerPhone,
              style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}
