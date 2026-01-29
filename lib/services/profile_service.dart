import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static final ProfileService instance = ProfileService._();
  ProfileService._();

  static const _keyName = 'profile_name';
  static const _keyPhotoPath = 'profile_photo_path';

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  Future<void> savePhotoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPhotoPath, path);
  }

  Future<String?> getPhotoPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhotoPath);
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyPhotoPath);
  }
}
