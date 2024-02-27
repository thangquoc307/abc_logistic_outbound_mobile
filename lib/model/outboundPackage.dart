import 'package:flutter_outbound/model/dimension.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/weight.dart';

class OutboundPackage {
  int? _id;
  String? _name;
  double? _pLength;
  double? _pWidth;
  double? _pHeight;
  double? _pWeight;
  String? _trackingNo;
  DimensionDto? _dimension;
  Weight? _weight;
  Set<OutboundPackageProductDetail>? _outboundPackageProductDetails;

  OutboundPackage(
      this._id,
      this._name,
      this._pLength,
      this._pWidth,
      this._pHeight,
      this._pWeight,
      this._trackingNo,
      this._dimension,
      this._weight,
      this._outboundPackageProductDetails);


  OutboundPackage.nullObject(String name){
    _id = null;
    _name = name;
    _pLength = 0;
    _pWidth = 0;
    _pHeight = 0;
    _pWeight = 0;
    _trackingNo = null;
    _dimension = null;
    _weight = null;
    _outboundPackageProductDetails = {};
  }

  OutboundPackage.fromJson(Map<String, dynamic> json) {
    _id =json['id'] ?? -1;
    _name = json['name'] ?? "";
    _pLength = json['plength'] ?? -1;
    _pWidth = json['pwidth'] ?? -1;
    _pHeight = json['pheight'] ?? -1;
    _pWeight = json['pweight'] ?? -1;
    _trackingNo = json['trackingNo'] ?? "";
    _dimension = json.containsKey('dimension')
        ? DimensionDto.fromJson(json['dimension'])
        : null;

    _weight = json.containsKey('weight')
        ? Weight.fromJson(json['weight'])
        : null;

    if (json.containsKey('outboundPackageProductDetails')) {
      var outboundPackageProductDetailsList = json['outboundPackageProductDetails'] as List;
      _outboundPackageProductDetails = outboundPackageProductDetailsList
          .map((item) => OutboundPackageProductDetail.fromJson(item))
          .toSet();
    } else {
      _outboundPackageProductDetails = null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'plength': _pLength,
      'pwidth': _pWidth,
      'pheight': _pHeight,
      'pweight': _pWeight,
      'trackingNo': _trackingNo,
      'dimension': _dimension?.toJson(),
      'weight': _weight?.toJson(),
      'outboundPackageProductDetails': _outboundPackageProductDetails
          ?.map((detail) => detail.toJson())
          ?.toList(),
    };
  }

  Set<OutboundPackageProductDetail>? get outboundPackageProductDetails =>
      _outboundPackageProductDetails;

  set outboundPackageProductDetails(Set<OutboundPackageProductDetail>? value) {
    _outboundPackageProductDetails = value;
  }

  Weight? get weight => _weight;

  set weight(Weight? value) {
    _weight = value;
  }

  DimensionDto? get dimension => _dimension;

  set dimension(DimensionDto? value) {
    _dimension = value;
  }

  String? get trackingNo => _trackingNo;

  set trackingNo(String? value) {
    _trackingNo = value;
  }

  double? get pWeight => _pWeight;

  set pWeight(double? value) {
    _pWeight = value;
  }

  double? get pHeight => _pHeight;

  set pHeight(double? value) {
    _pHeight = value;
  }

  double? get pWidth => _pWidth;

  set pWidth(double? value) {
    _pWidth = value;
  }

  double? get pLength => _pLength;

  set pLength(double? value) {
    _pLength = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'OutboundPackage{_id: $_id, _name: $_name, _pLength: $_pLength, _pWidth: $_pWidth, _pHeight: $_pHeight, _pWeight: $_pWeight, _trackingNo: $_trackingNo, _dimension: $_dimension, _weight: $_weight, _outboundPackageProductDetails: $_outboundPackageProductDetails}';
  }
}