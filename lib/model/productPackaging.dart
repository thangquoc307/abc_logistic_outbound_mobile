import 'package:flutter_outbound/model/unitOfMeasurement.dart';

class ProductPackaging {
  int? id;
  num? size;
  num? mcVolume;
  num? mcNetWeight;
  num? mcShipment;
  num? mcLength;
  num? mcWidth;
  num? mcHeight;
  UnitOfMeasurement? unitOfMeasurement;
  num? unetWeight;
  num? uvolume;
  num? uheight;
  num? ulength;
  num? uwidth;
  num? ushipment;

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
        this.unetWeight,
        this.uvolume,
        this.uheight,
        this.ulength,
        this.uwidth,
        this.ushipment});

  ProductPackaging.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    mcVolume = json['mcVolume'];
    mcNetWeight = json['mcNetWeight'];
    mcShipment = json['mcShipment'];
    mcLength = json['mcLength'];
    mcWidth = json['mcWidth'];
    mcHeight = json['mcHeight'];
    unitOfMeasurement = json['unitOfMeasurement'] != null
        ? UnitOfMeasurement.fromJson(json['unitOfMeasurement'])
        : null;
    unetWeight = json['unetWeight'];
    uvolume = json['uvolume'];
    uheight = json['uheight'];
    ulength = json['ulength'];
    uwidth = json['uwidth'];
    ushipment = json['ushipment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['mcVolume'] = this.mcVolume;
    data['mcNetWeight'] = this.mcNetWeight;
    data['mcShipment'] = this.mcShipment;
    data['mcLength'] = this.mcLength;
    data['mcWidth'] = this.mcWidth;
    data['mcHeight'] = this.mcHeight;
    if (this.unitOfMeasurement != null) {
      data['unitOfMeasurement'] = this.unitOfMeasurement!.toJson();
    }
    data['unetWeight'] = this.unetWeight;
    data['uvolume'] = this.uvolume;
    data['uheight'] = this.uheight;
    data['ulength'] = this.ulength;
    data['uwidth'] = this.uwidth;
    data['ushipment'] = this.ushipment;
    return data;
  }
}