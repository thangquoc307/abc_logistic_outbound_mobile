import 'outboundPackage.dart';

class ShippingPackage {
  int? _id;
  OutboundPackage? _outboundPackage;


  ShippingPackage(this._id, this._outboundPackage);

  int? get id => _id;
  set id(int? id) => _id = id;
  OutboundPackage? get outboundPackage => _outboundPackage;
  set outboundPackage(OutboundPackage? outboundPackage) =>
      _outboundPackage = outboundPackage;

  ShippingPackage.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _outboundPackage = json['outboundPackage'] != null
        ? OutboundPackage.fromJson(json['outboundPackage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_outboundPackage != null) {
      data['outboundPackage'] = _outboundPackage!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ShippingPackages{_id: $_id, _outboundPackage: $_outboundPackage}';
  }
}