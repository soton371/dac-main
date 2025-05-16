import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);

class AuthLocalDB {
  final String authKey = "authKeyDac";

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<void> setToken(String token) async {
    await storage.write(key: authKey, value: token);
  }

  Future<String?> getToken() async {
    final token = await storage.read(key: authKey);
    if (token == null) {
      return null;
    }
    return token;
  }

  Future<void> removeToken() async {
    await storage.delete(key: authKey);
  }
}
