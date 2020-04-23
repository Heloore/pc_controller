class VolumeState {
  final bool muted;
  final int volumeLevel;

  VolumeState(this.muted, this.volumeLevel);
}

class VolumeInitialState extends VolumeState {
  VolumeInitialState() : super(false, 0);
}

class VolumeMuted extends VolumeState {
  VolumeMuted(int volumeLevel) : super(true, volumeLevel);
}

class VolumeSet extends VolumeState {
  VolumeSet(int volumeLevel) : super(false, volumeLevel);
}
