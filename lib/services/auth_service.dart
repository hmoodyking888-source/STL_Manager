import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_config.dart';

class AuthService {
  static Future<bool> checkSubscriptionStatus() async {
    String deviceId = "user_device_01"; // يمكن استبدالها بـ UUID حقيقي لاحقاً
    try {
      final response = await http.get(
          Uri.parse('${AppConfig.firebaseDbUrl}/activations/$deviceId.json'));
      if (response.body == 'null') {
        await _register(deviceId);
        return false;
      } else {
        final data = json.decode(response.body);
        DateTime start = DateTime.parse(data['date']);
        return DateTime.now().difference(start).inDays >= AppConfig.trialDays;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> _register(String id) async {
    await http.put(Uri.parse('${AppConfig.firebaseDbUrl}/activations/$id.json'),
        body: json.encode(
            {'date': DateTime.now().toIso8601String(), 'status': 'trial'}));
  }
}
