import 'unitOfMeasurement.dart';

class ProductPackaging {
  int? id;
  double? size;
  double? mcVolume;
  double? mcNetWeight;
  double? mcShipment;
  double? mcLength;
  double? mcWidth;
  double? mcHeight;
  UnitOfMeasurement? unitOfMeasurement;
  double? ulength;
  double? uheight;
  double? ushipment;
  double? uwidth;
  double? uvolume;
  double? unetWeight;

  ProductPackaging(
      {this.id,
        this.size,
        this.mcVolume,
        this.mcNetWeight,
        this.mcShipment,
        this.mcLength,
        this.mcWidth,
        this.mcHeight,
        this.unitOfMeasurement,
        this.ulength,
        this.uheight,
        this.ushipment,
        this.uwidth,
        this.uvolume,
        this.unetWeight});

  ProductPackaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    mcVolume = json['mcVolume'];
    mcNetWeight = json['mcNetWeight'];
    mcShipment = json['mcShipment'];
    mcLength = json['mcLength'];
    mcWidth = json['mcWidth'];
    mcHeight = json['mcHeight'];
    unitOfMeasurement = json['unitOfMeasurement'];
    ulength = json['ulength'];
    uheight = json['uheight'];
    ushipment = json['ushipment'];
    uwidth = json['uwidth'];
    uvolume = json['uvolume'];
    unetWeight = json['unetWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['mcVolume'] = this.mcVolume;
    data['mcNetWeight'] = this.mcNetWeight;
    data['mcShipment'] = this.mcShipment;
    data['mcLength'] = this.mcLength;
    data['mcWidth'] = this.mcWidth;
    data['mcHeight'] = this.mcHeight;
    data['unitOfMeasurement'] = this.unitOfMeasurement;
    data['ulength'] = this.ulength;
    data['uheight'] = this.uheight;
    data['ushipment'] = this.ushipment;
    data['uwidth'] = this.uwidth;
    data['uvolume'] = this.uvolume;
    data['unetWeight'] = this.unetWeight;
    return data;
  }
}