import 'package:fluto/fluto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFlutoStorage extends FlutoStorage {
  static const String storageKey = "fluto_data";

  @override
  Future<String?> load() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(storageKey);
  }

  @override
  Future<bool> save(String data) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString(storageKey, data);
  }
}

class FlutterSecureStorageFlutoStorage extends FlutoStorage {
  // Create storage
  late final storage = const FlutterSecureStorage();

  static const String storageKey = "fluto_data";

  @override
  Future<String?> load() async {
    return storage.read(key: storageKey);
  }

  @override
  Future<bool> save(String data) async {
    try {
      storage.write(key: storageKey, value: data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
