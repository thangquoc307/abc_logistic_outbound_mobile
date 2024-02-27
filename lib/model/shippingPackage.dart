import 'outboundPackage.dart';

class ShippingPackage {
  int? _id;
  OutboundPackage? _outboundPackage;

  ShippingPackages({int? id, OutboundPackage? outboundPackage}) {
    if (id != null) {
      this._id = id;
    }
    if (outboundPackage != null) {
      this._outboundPackage = outboundPackage;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  OutboundPackage? get outboundPackage => _outboundPackage;
  set outboundPackage(OutboundPackage? outboundPackage) =>
      _outboundPackage = outboundPackage;

  ShippingPackage.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _outboundPackage = json['outboundPackage'] != null
        ? new OutboundPackage.fromJson(json['outboundPackage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    if (this._outboundPackage != null) {
      data['outboundPackage'] = this._outboundPackage!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ShippingPackages{_id: $_id, _outboundPackage: $_outboundPackage}';
  }
}