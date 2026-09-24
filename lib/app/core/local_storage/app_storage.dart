import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  AppStorage._internal();

  factory AppStorage() => _instance;

  static final AppStorage _instance = AppStorage._internal();

  late Box _box;

  Future<void> initAppStorage() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('appInfo');
  }

  String? getToken() {
    return _box.get(_token) as String?;
  }

  Future<void> putToken(String token) async {
    await _box.put(_token, token);
  }

  Future<void> clearAllData() async {
    await _box.clear();
  }

  final String _token = 'token';
}
