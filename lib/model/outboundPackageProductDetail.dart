import 'package:flutter_outbound/model/product.dart';

class OutboundPackageProductDetail {
  int? _id;
  double? _packagedQty;
  Product? _product;
  double? _packagedUnitQty;
  String? _sku;


  OutboundPackageProductDetail(this._id, this._packagedQty, this._product,
      this._packagedUnitQty, this._sku);

  int? get id => _id;
  set id(int? id) => _id = id;
  double? get packagedQty => _packagedQty;
  set packagedQty(double? packagedQty) => _packagedQty = packagedQty;
  Product? get product => _product;
  set product(Product? product) => _product = product;
  double? get packagedUnitQty => _packagedUnitQty;
  set packagedUnitQty(double? packagedUnitQty) =>
      _packagedUnitQty = packagedUnitQty;
  String? get sku => _sku;
  set sku(String? sku) => _sku = sku;

  OutboundPackageProductDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _packagedQty = json['packagedQty'];
    _product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    _packagedUnitQty = json['packagedUnitQty'];
    _sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['packagedQty'] = this._packagedQty;
    if (this._product != null) {
      data['product'] = this._product!.toJson();
    }
    data['packagedUnitQty'] = this._packagedUnitQty;
    data['sku'] = this._sku;
    return data;
  }
}