import 'outboundLocationProductDetails.dart';
import 'product.dart';

class OutboundProductDetail {
  int? _id;
  num? _preFulfilledQty;
  num? _pickedQty;
  num? _shippedQty;
  Product? _product;
  List<OutboundLocationProductDetails>? _outboundLocationProductDetails;
  num? _packagedQty;
  num? _preFulfilledUnitQty;
  num? _pickedUnitQty;
  num? _packagedUnitQty;
  num? _shippedUnitQty;
  num? _requestedQty;
  num? _requestedUnitQty;
  String? _sku;

  OutboundProductDetail(
      this._id,
      this._preFulfilledQty,
      this._pickedQty,
      this._shippedQty,
      this._product,
      this._outboundLocationProductDetails,
      this._packagedQty,
      this._preFulfilledUnitQty,
      this._pickedUnitQty,
      this._packagedUnitQty,
      this._shippedUnitQty,
      this._requestedQty,
      this._requestedUnitQty,
      this._sku);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['preFulfilledQty'] = this._preFulfilledQty;
    data['pickedQty'] = this._pickedQty;
    data['shippedQty'] = this._shippedQty;
    if (this._product != null) {
      data['product'] = this._product!.toJson();
    }
    if (this._outboundLocationProductDetails != null) {
      data['outboundLocationProductDetails'] =
          this._outboundLocationProductDetails!.map((v) => v.toJson()).toList();
    }
    data['packagedQty'] = this._packagedQty;
    data['preFulfilledUnitQty'] = this._preFulfilledUnitQty;
    data['pickedUnitQty'] = this._pickedUnitQty;
    data['packagedUnitQty'] = this._packagedUnitQty;
    data['shippedUnitQty'] = this._shippedUnitQty;
    data['requestedQty'] = this._requestedQty;
    data['requestedUnitQty'] = this._requestedUnitQty;
    data['sku'] = this._sku;
    return data;
  }

  OutboundProductDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'] ?? -1;
    _preFulfilledQty = json['preFulfilledQty'] ?? -1;
    _pickedQty = json['pickedQty'] ?? -1;
    _shippedQty = json['shippedQty'] ?? -1;
    _product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['outboundLocationProductDetails'] != null) {
      _outboundLocationProductDetails = <OutboundLocationProductDetails>[];
      json['outboundLocationProductDetails'].forEach((v) {
        _outboundLocationProductDetails!
            .add(new OutboundLocationProductDetails.fromJson(v));
      });
    }
    _packagedQty = json['packagedQty'] ?? -1;
    _preFulfilledUnitQty = json['preFulfilledUnitQty'] ?? -1;
    _pickedUnitQty = json['pickedUnitQty'] ?? -1;
    _packagedUnitQty = json['packagedUnitQty'] ?? -1;
    _shippedUnitQty = json['shippedUnitQty'] ?? -1;
    _requestedQty = json['requestedQty'] ?? -1;
    _requestedUnitQty = json['requestedUnitQty'] ?? -1;
    _sku = json['sku'] ?? "";
  }

  String? get sku => _sku;

  set sku(String? value) {
    _sku = value;
  }

  num? get requestedUnitQty => _requestedUnitQty;

  set requestedUnitQty(num? value) {
    _requestedUnitQty = value;
  }

  num? get requestedQty => _requestedQty;

  set requestedQty(num? value) {
    _requestedQty = value;
  }

  num? get shippedUnitQty => _shippedUnitQty;

  set shippedUnitQty(num? value) {
    _shippedUnitQty = value;
  }

  num? get packagedUnitQty => _packagedUnitQty;

  set packagedUnitQty(num? value) {
    _packagedUnitQty = value;
  }

  num? get pickedUnitQty => _pickedUnitQty;

  set pickedUnitQty(num? value) {
    _pickedUnitQty = value;
  }

  num? get preFulfilledUnitQty => _preFulfilledUnitQty;

  set preFulfilledUnitQty(num? value) {
    _preFulfilledUnitQty = value;
  }

  num? get packagedQty => _packagedQty;

  set packagedQty(num? value) {
    _packagedQty = value;
  }

  List<OutboundLocationProductDetails>? get outboundLocationProductDetails =>
      _outboundLocationProductDetails;

  set outboundLocationProductDetails(
      List<OutboundLocationProductDetails>? value) {
    _outboundLocationProductDetails = value;
  }

  Product? get product => _product;

  set product(Product? value) {
    _product = value;
  }

  num? get shippedQty => _shippedQty;

  set shippedQty(num? value) {
    _shippedQty = value;
  }

  num? get pickedQty => _pickedQty;

  set pickedQty(num? value) {
    _pickedQty = value;
  }

  num? get preFulfilledQty => _preFulfilledQty;

  set preFulfilledQty(num? value) {
    _preFulfilledQty = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'OutboundProductDetail{_id: $_id, _preFulfilledQty: $_preFulfilledQty, _pickedQty: $_pickedQty, _shippedQty: $_shippedQty, _product: $_product, _outboundLocationProductDetails: $_outboundLocationProductDetails, _packagedQty: $_packagedQty, _preFulfilledUnitQty: $_preFulfilledUnitQty, _pickedUnitQty: $_pickedUnitQty, _packagedUnitQty: $_packagedUnitQty, _shippedUnitQty: $_shippedUnitQty, _requestedQty: $_requestedQty, _requestedUnitQty: $_requestedUnitQty, _sku: $_sku}';
  }
}