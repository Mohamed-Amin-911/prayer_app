import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static writeIsSaved(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String> readData(String key) async {
    String value = await storage.read(key: key) ?? 'No data found!';

    return value;
  }

  static Future<String> readIsSaved(String key) async {
    String value = await storage.read(key: key) ?? 'No data found!';

    return value;
  }

  Future<String> readPass(String key) async {
    String value = await storage.read(key: key) ?? 'No data found!';
    print('Data read from secure storage: $value');
    return value;
  }
}
