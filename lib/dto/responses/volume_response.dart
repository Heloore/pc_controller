class VolumeReponse {
  final int volume;
  final bool muted;

  VolumeReponse({this.volume, this.muted});

  factory VolumeReponse.fromJson(Map<String, dynamic> json) => VolumeReponse(volume: json['volume'], muted: json["muted"]);

  Map<String, dynamic> toJson() => {"volume": this.volume, "muted": this.muted};
}
