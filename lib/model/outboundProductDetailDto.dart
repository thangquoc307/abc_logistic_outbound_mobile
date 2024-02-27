class OutboundProductDetailDto {
  int? _id;
  String? _upc;
  String? _orderNo;
  int? _outboundId;
  int? _shippedQty;
  String? _sku;
  int? _pickedQty;
  int? _packagedQty;
  int? _productId;
  String? _productName;
  String? _customerProjectNo;
  int? _preFulfilledQty;

  OutboundProductDetailDto(
      {int? id,
        String? upc,
        String? orderNo,
        int? outboundId,
        int? shippedQty,
        String? sku,
        int? pickedQty,
        int? packagedQty,
        int? productId,
        String? productName,
        String? customerProjectNo,
        int? preFulfilledQty}) {
    if (id != null) {
      this._id = id;
    }
    if (upc != null) {
      this._upc = upc;
    }
    if (orderNo != null) {
      this._orderNo = orderNo;
    }
    if (outboundId != null) {
      this._outboundId = outboundId;
    }
    if (shippedQty != null) {
      this._shippedQty = shippedQty;
    }
    if (sku != null) {
      this._sku = sku;
    }
    if (pickedQty != null) {
      this._pickedQty = pickedQty;
    }
    if (packagedQty != null) {
      this._packagedQty = packagedQty;
    }
    if (productId != null) {
      this._productId = productId;
    }
    if (productName != null) {
      this._productName = productName;
    }
    if (customerProjectNo != null) {
      this._customerProjectNo = customerProjectNo;
    }
    if (preFulfilledQty != null) {
      this._preFulfilledQty = preFulfilledQty;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get upc => _upc;
  set upc(String? upc) => _upc = upc;
  String? get orderNo => _orderNo;
  set orderNo(String? orderNo) => _orderNo = orderNo;
  int? get outboundId => _outboundId;
  set outboundId(int? outboundId) => _outboundId = outboundId;
  int? get shippedQty => _shippedQty;
  set shippedQty(int? shippedQty) => _shippedQty = shippedQty;
  String? get sku => _sku;
  set sku(String? sku) => _sku = sku;
  int? get pickedQty => _pickedQty;
  set pickedQty(int? pickedQty) => _pickedQty = pickedQty;
  int? get packagedQty => _packagedQty;
  set packagedQty(int? packagedQty) => _packagedQty = packagedQty;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get customerProjectNo => _customerProjectNo;
  set customerProjectNo(String? customerProjectNo) =>
      _customerProjectNo = customerProjectNo;
  int? get preFulfilledQty => _preFulfilledQty;
  set preFulfilledQty(int? preFulfilledQty) =>
      _preFulfilledQty = preFulfilledQty;

  OutboundProductDetailDto.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _upc = json['upc'];
    _orderNo = json['order_no'];
    _outboundId = json['outbound_id'];
    _shippedQty = json['shipped_qty'];
    _sku = json['sku'];
    _pickedQty = json['picked_qty'];
    _packagedQty = json['packaged_qty'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _customerProjectNo = json['customer_project_no'];
    _preFulfilledQty = json['pre_fulfilled_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['upc'] = this._upc;
    data['order_no'] = this._orderNo;
    data['outbound_id'] = this._outboundId;
    data['shipped_qty'] = this._shippedQty;
    data['sku'] = this._sku;
    data['picked_qty'] = this._pickedQty;
    data['packaged_qty'] = this._packagedQty;
    data['product_id'] = this._productId;
    data['product_name'] = this._productName;
    data['customer_project_no'] = this._customerProjectNo;
    data['pre_fulfilled_qty'] = this._preFulfilledQty;
    return data;
  }

  @override
  String toString() {
    return 'OutboundProductDetailDto{_id: $_id, _upc: $_upc, _orderNo: $_orderNo, _outboundId: $_outboundId, _shippedQty: $_shippedQty, _sku: $_sku, _pickedQty: $_pickedQty, _packagedQty: $_packagedQty, _productId: $_productId, _productName: $_productName, _customerProjectNo: $_customerProjectNo, _preFulfilledQty: $_preFulfilledQty}';
  }
}
