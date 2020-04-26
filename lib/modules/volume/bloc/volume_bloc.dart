import 'dart:async';

import 'package:pc_controll/dto/responses/volume_response.dart';
import 'package:pc_controll/modules/volume/model/volume_model.dart';
import 'package:pc_controll/repositories/volume_repository.dart';

import 'package:rxdart/rxdart.dart';

class VolumeBloc {
  final BehaviorSubject<VolumeModel> _modelStream = BehaviorSubject<VolumeModel>();
  Stream<VolumeModel> get modelStream => _modelStream.stream;

  static const int maxVolume = 100;
  static const int minVolume = 0;

  VolumeBloc() {
    getCurrentVolume();
  }

  void dispose() {
    _modelStream.close();
  }

  void getCurrentVolume() async {
    VolumeReponse resp;
    try {
      resp = await VolumeRepository().getCurrentVolume();
    } catch (e) {
      _modelStream.sink.addError("Error fetching data. Please try again");
      return;
    }
    _modelStream.sink.add(VolumeModel(resp.volume, resp.muted));
  }

  void setVolumeLevel(int volume) async {
    bool resp;
    try {
      resp = await VolumeRepository().setVolumeLevel(volume);
    } catch (_) {
      return;
    }
    if (resp) {
      _modelStream.sink.add(VolumeModel(volume, _modelStream.stream.value.muted));
    }
  }

  void muteVolume() async {
    bool resp;
    try {
      resp = await VolumeRepository().muteVolume();
    } catch (_) {
      return;
    }
    if (resp) {
      _modelStream.sink.add(VolumeModel(_modelStream.stream.value.volume, true));
    }
  }

  void unmuteVolume() async {
    bool resp;
    try {
      resp = await VolumeRepository().unmuteVolume();
    } catch (_) {
      return;
    }
    if (resp) {
      _modelStream.sink.add(VolumeModel(_modelStream.stream.value.volume, false));
    }
  }
}
