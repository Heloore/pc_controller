import 'package:pc_controll/connection_controller/connection.dart';
import 'package:pc_controll/storage/storage.dart';

// TODO: implement injector

class SettingsRepository {
  static final SettingsRepository _storage = SettingsRepository._();

  factory SettingsRepository() => _storage;
  SettingsRepository._();

  initAddressToController() async {
    await setAddressToConnectionController(await Storage().getSavedIpAddress());
  }

  setAddressToConnectionController(String address) async {
    if (address != null && address.isNotEmpty) {
      await ConnectionController().setApiPath(address);
    } else {
      throw ArgumentError("address is null or empty");
    }
  }
}
