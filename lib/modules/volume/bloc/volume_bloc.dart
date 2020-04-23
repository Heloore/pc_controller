import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pc_controll/modules/volume/bloc/volume_event.dart';
import 'package:pc_controll/modules/volume/bloc/volume_state.dart';
import 'package:pc_controll/repositories/volume_repository.dart';


class VolumeBloc extends Bloc<VolumeEvent, VolumeState> {
  VolumeBloc() {
    getCurrentVolume();
  }

  getCurrentVolume() async {
  //  get volume level and sync UI
  }

  @override
  VolumeState get initialState => VolumeInitialState();

  @override
  Stream<VolumeState> mapEventToState(VolumeEvent event) async* {
    if (event is VolumeMuteEvent) {
      try {
        if (await VolumeRepository().muteVolume()) {
          yield VolumeMuted(state.volumeLevel);
        }
      } catch (_) {}
    } else if (event is VolumeUnmuteEvent) {
      try {
        if (await VolumeRepository().unmuteVolume()) {
          yield VolumeSet(state.volumeLevel);
        }
      } catch (_) {
      }
    } else if (event is VolumeSetEvent) {
      try {
        await VolumeRepository().setVolumeLevel(event.volumeLevel);
      } catch (_) {
      }
    } else {
      throw Exception('unhandled event: $event');
    }
  }
}
