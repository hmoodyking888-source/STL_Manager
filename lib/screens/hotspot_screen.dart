import 'package:flutter/material.dart';
import '../app_config.dart';

class HotspotScreen extends StatelessWidget {
  const HotspotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppConfig.cardGrey,
        title: const Text("إدارة الهوتسبوت",
            style: TextStyle(color: AppConfig.primaryGold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildQuickStats(),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // مثال لعدد المستخدمين
              itemBuilder: (context, index) => _buildUserTile(index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.primaryGold,
        child: const Icon(Icons.person_add, color: Colors.black),
        onPressed: () => _showAddUserDialog(context),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppConfig.cardGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("النشط", "150", Colors.green),
          _statItem("المنتهي", "24", Colors.red),
          _statItem("الإجمالي", "174", AppConfig.primaryGold),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildUserTile(int index) {
    return Card(
      color: AppConfig.cardGrey,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.person, color: AppConfig.primaryGold),
        ),
        title: Text("User_$index", style: const TextStyle(color: Colors.white)),
        subtitle: const Text("ينتهي في: 2026/05/20",
            style: TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: const Icon(Icons.more_vert, color: AppConfig.primaryGold),
        onTap: () {}, // لفتح القائمة المنبثقة (تجديد، قطع، فتح سرعة)
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    // كود نافذة إضافة كرت جديد أو توليد مجموعة كروت
  }
}
