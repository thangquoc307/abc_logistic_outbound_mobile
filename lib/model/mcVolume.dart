class McVolume {
  int? id;
  String? volumeUnit;

  McVolume({this.id, this.volumeUnit});

  McVolume.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volumeUnit = json['volumeUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['volumeUnit'] = this.volumeUnit;
    return data;
  }
}