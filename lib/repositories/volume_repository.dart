import 'dart:convert';

import 'package:pc_controll/connection_controller/connection.dart';
import 'package:pc_controll/dto/requests/request.dart';
import 'package:pc_controll/dto/responses/volume_response.dart';

class VolumeRepository {
  static final VolumeRepository _volumeRepository = VolumeRepository._();

  factory VolumeRepository() => _volumeRepository;
  VolumeRepository._();

  Future<VolumeReponse> getCurrentVolume() async {
    var resp = await ConnectionController().makeRequest(GetVolumeRequest());
    return VolumeReponse.fromJson(json.decode(resp.body));
  }

  Future<bool> setVolumeLevel(int volumeLevel) async {
    var resp = await ConnectionController().makeRequest((SetVolumeRequest(volumeLevel)));
    return resp.statusCode == 200;
  }

  Future<bool> muteVolume() async {
    var resp = await ConnectionController().makeRequest(MuteVolumeRequest());
    return resp.statusCode == 200;
  }

  Future<bool> unmuteVolume() async {
    var resp = await ConnectionController().makeRequest(UnmuteVolumeRequest());
    return resp.statusCode == 200;
  }
}
