class McWeight {
  int? id;
  String? weightUnit;

  McWeight({this.id, this.weightUnit});

  McWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weightUnit = json['weightUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weightUnit'] = this.weightUnit;
    return data;
  }
}