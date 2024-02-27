import 'location.dart';

class OutboundLocationProductDetails {
  int? _id;
  Location? _location;
  num? _pickedQty;
  num? _pickedUnitQty;

  OutboundLocationProductDetails(
      {int? id, Location? location, num? pickedQty, num? pickedUnitQty}) {
    if (id != null) {
      this._id = id;
    }
    if (location != null) {
      this._location = location;
    }
    if (pickedQty != null) {
      this._pickedQty = pickedQty;
    }
    if (pickedUnitQty != null) {
      this._pickedUnitQty = pickedUnitQty;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  Location? get location => _location;
  set location(Location? location) => _location = location;
  num? get pickedQty => _pickedQty;
  set pickedQty(num? pickedQty) => _pickedQty = pickedQty;
  num? get pickedUnitQty => _pickedUnitQty;
  set pickedUnitQty(num? pickedUnitQty) => _pickedUnitQty = pickedUnitQty;

  OutboundLocationProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    _pickedQty = json['pickedQty'];
    _pickedUnitQty = json['pickedUnitQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    if (this._location != null) {
      data['location'] = this._location!.toJson();
    }
    data['pickedQty'] = this._pickedQty;
    data['pickedUnitQty'] = this._pickedUnitQty;
    return data;
  }

  @override
  String toString() {
    return 'OutboundLocationProductDetails{_id: $_id, _location: $_location, _pickedQty: $_pickedQty, _pickedUnitQty: $_pickedUnitQty}';
  }
}