class McDimension {
  int? id;
  String? dimensionUnit;

  McDimension({this.id, this.dimensionUnit});

  McDimension.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dimensionUnit = json['dimensionUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dimensionUnit'] = this.dimensionUnit;
    return data;
  }
}