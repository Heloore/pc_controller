import 'package:pc_controll/repositories/settings_repository.dart';
// import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  String pcAddress;
  // final BehaviorSubject<String> addressStream = BehaviorSubject<String>.seeded("");
  // Stream<String> get a => addressStream.stream;

  SettingsBloc();

  Future<bool> saveNewAddress(String address) async {
    try {
      await SettingsRepository().setAddressToConnectionController(address);
      pcAddress = address;
      // addressStream.sink.add(pcAddress);
      return true;
    } catch (_) {}
    return false;
  }

  // dispose() {
  //   addressStream.close();
  // }
}
