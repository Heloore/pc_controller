import 'package:shared_preferences/shared_preferences.dart';

const sharedPrefsIPKey = "pc_controller_ip_address";

class Repository {
  static final Repository _repository = Repository._();

  factory Repository() => _repository;
  Repository._();

  Future<String> getSavedIpAddress() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    return sPrefs.getString(sharedPrefsIPKey);
  }

  Future<void> saveIpAddress(String ipAddress) async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    await sPrefs.setString(sharedPrefsIPKey, ipAddress);
  }
}
