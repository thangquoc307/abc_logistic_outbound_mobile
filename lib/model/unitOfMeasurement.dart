import 'mcDimension.dart';
import 'mcVolume.dart';
import 'mcWeight.dart';

class UnitOfMeasurement {
  int? id;
  McWeight? mcWeight;
  McDimension? mcDimension;
  McVolume? mcVolume;
  McWeight? unitWeight;
  McDimension? unitDimension;
  McVolume? unitVolumeUnit;

  UnitOfMeasurement(
      {this.id,
        this.mcWeight,
        this.mcDimension,
        this.mcVolume,
        this.unitWeight,
        this.unitDimension,
        this.unitVolumeUnit});

  UnitOfMeasurement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mcWeight = json['mcWeight'] != null
        ? new McWeight.fromJson(json['mcWeight'])
        : null;
    mcDimension = json['mcDimension'] != null
        ? new McDimension.fromJson(json['mcDimension'])
        : null;
    mcVolume = json['mcVolume'] != null
        ? new McVolume.fromJson(json['mcVolume'])
        : null;
    unitWeight = json['unitWeight'] != null
        ? new McWeight.fromJson(json['unitWeight'])
        : null;
    unitDimension = json['unitDimension'] != null
        ? new McDimension.fromJson(json['unitDimension'])
        : null;
    unitVolumeUnit = json['unitVolumeUnit'] != null
        ? new McVolume.fromJson(json['unitVolumeUnit'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.mcWeight != null) {
      data['mcWeight'] = this.mcWeight!.toJson();
    }
    if (this.mcDimension != null) {
      data['mcDimension'] = this.mcDimension!.toJson();
    }
    if (this.mcVolume != null) {
      data['mcVolume'] = this.mcVolume!.toJson();
    }
    if (this.unitWeight != null) {
      data['unitWeight'] = this.unitWeight!.toJson();
    }
    if (this.unitDimension != null) {
      data['unitDimension'] = this.unitDimension!.toJson();
    }
    if (this.unitVolumeUnit != null) {
      data['unitVolumeUnit'] = this.unitVolumeUnit!.toJson();
    }
    return data;
  }
}
