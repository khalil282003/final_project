import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppHelper{
  static const storage = FlutterSecureStorage();
  static String baseUrl="http://192.168.1.11:3000/";
  static Future<void> storeToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }
}