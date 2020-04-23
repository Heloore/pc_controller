import 'package:shared_preferences/shared_preferences.dart';

const sharedPrefsIPKey = "pc_controller_ip_address";

class Storage {
  static final Storage _storage = Storage._();

  factory Storage() => _storage;
  Storage._();

  Future<String> getSavedIpAddress() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    return sPrefs.getString(sharedPrefsIPKey);
  }

  Future<void> saveIpAddress(String ipAddress) async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    await sPrefs.setString(sharedPrefsIPKey, ipAddress);
  }
}
