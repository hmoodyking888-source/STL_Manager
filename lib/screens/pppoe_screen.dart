import 'package:flutter/material.dart';
import '../app_config.dart';

class PPPoEScreen extends StatefulWidget {
  const PPPoEScreen({super.key});

  @override
  State<PPPoEScreen> createState() => _PPPoEScreenState();
}

class _PPPoEScreenState extends State<PPPoEScreen> {
  // قائمة بيانات تجريبية لمحاكاة حسابات PPPoE
  final List<Map<String, dynamic>> pppoeUsers = [
    {
      "user": "user_ahmed_01",
      "profile": "8Mbps",
      "status": "active",
      "uptime": "2d 4h"
    },
    {
      "user": "user_ali_99",
      "profile": "4Mbps",
      "status": "expired",
      "uptime": "0s"
    },
    {
      "user": "user_khaled_stn",
      "profile": "16Mbps",
      "status": "active",
      "uptime": "5h 22m"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppConfig.backgroundBlack,
        elevation: 0,
        title: const Text("إدارة البرودباند",
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
          _buildSummaryCards(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: pppoeUsers.length,
              itemBuilder: (context, index) =>
                  _buildUserCard(pppoeUsers[index]),
            ),
          ),
          _buildDeveloperFooter(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem("الكل", "${pppoeUsers.length}", Colors.blue),
          _summaryItem("متصل", "2", Colors.green),
          _summaryItem("منتهي", "1", Colors.red),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    bool isActive = user['status'] == "active";
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppConfig.cardGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.settings_input_antenna,
              color: isActive ? AppConfig.primaryGold : Colors.grey),
        ),
        title: Text(user['user'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("الباقة: ${user['profile']} | Uptime: ${user['uptime']}",
            style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, color: AppConfig.primaryGold),
          onPressed: () => _showUserOptions(user),
        ),
      ),
    );
  }

  void _showUserOptions(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppConfig.cardGrey,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user['user'],
                style: const TextStyle(
                    color: AppConfig.primaryGold,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10),
            _optionTile(Icons.refresh, "تجديد الصلاحية", Colors.green, () {}),
            _optionTile(
                Icons.speed, "فتح السرعة القصوى", AppConfig.primaryGold, () {}),
            _optionTile(Icons.block, "قطع الخدمة مؤقتاً", Colors.orange, () {}),
            _optionTile(Icons.delete_forever, "حذف الحساب", Colors.red, () {}),
          ],
        ),
      ),
    );
  }

  Widget _optionTile(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _buildDeveloperFooter() {
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
