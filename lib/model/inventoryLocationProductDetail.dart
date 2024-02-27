class InventoryLocationProductDetail {
  int? _totalUnitQty;
  int? _totalMcQty;
  String? _locationTypeName;
  int? _locationId;
  String? _locationNo;
  String? _productName;
  int? _productId;

  InventoryLocationProductDetail(
      {int? totalUnitQty,
        int? totalMcQty,
        String? locationTypeName,
        int? locationId,
        String? locationNo,
        String? productName,
        int? productId}) {
    if (totalUnitQty != null) {
      this._totalUnitQty = totalUnitQty;
    }
    if (totalMcQty != null) {
      this._totalMcQty = totalMcQty;
    }
    if (locationTypeName != null) {
      this._locationTypeName = locationTypeName;
    }
    if (locationId != null) {
      this._locationId = locationId;
    }
    if (locationNo != null) {
      this._locationNo = locationNo;
    }
    if (productName != null) {
      this._productName = productName;
    }
    if (productId != null) {
      this._productId = productId;
    }
  }

  int? get totalUnitQty => _totalUnitQty;
  set totalUnitQty(int? totalUnitQty) => _totalUnitQty = totalUnitQty;
  int? get totalMcQty => _totalMcQty;
  set totalMcQty(int? totalMcQty) => _totalMcQty = totalMcQty;
  String? get locationTypeName => _locationTypeName;
  set locationTypeName(String? locationTypeName) =>
      _locationTypeName = locationTypeName;
  int? get locationId => _locationId;
  set locationId(int? locationId) => _locationId = locationId;
  String? get locationNo => _locationNo;
  set locationNo(String? locationNo) => _locationNo = locationNo;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;

  InventoryLocationProductDetail.fromJson(Map<String, dynamic> json) {
    _totalUnitQty = json['total_unit_qty'];
    _totalMcQty = json['total_mc_qty'];
    _locationTypeName = json['location_type_name'];
    _locationId = json['location_id'];
    _locationNo = json['location_no'];
    _productName = json['product_name'];
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_unit_qty'] = this._totalUnitQty;
    data['total_mc_qty'] = this._totalMcQty;
    data['location_type_name'] = this._locationTypeName;
    data['location_id'] = this._locationId;
    data['location_no'] = this._locationNo;
    data['product_name'] = this._productName;
    data['product_id'] = this._productId;
    return data;
  }

  @override
  String toString() {
    return 'InventoryLocationProductDetail{_locationId: $_locationId}';
  }
}
