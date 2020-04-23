class VolumeEvent {}

class VolumeSetEvent extends VolumeEvent {
  final int volumeLevel;
  VolumeSetEvent(this.volumeLevel);
}

class VolumeMuteEvent extends VolumeEvent {}

class VolumeUnmuteEvent extends VolumeEvent {}
