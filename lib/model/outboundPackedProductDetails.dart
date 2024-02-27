class OutboundPackedProductDetails {
  String? _name;
  int? _id;
  String? _customerProjectNo;
  int? _dimensionId;
  String? _trackingNo;
  String? _orderNo;
  int? _pWeight;
  int? _pWidth;
  int? _outboundId;
  int? _pHeight;
  int? _customerId;
  int? _weightId;
  int? _pLength;
  String? _customerName;

  OutboundPackedProductDetails(
      this._name,
      this._id,
      this._customerProjectNo,
      this._dimensionId,
      this._trackingNo,
      this._orderNo,
      this._pWeight,
      this._pWidth,
      this._outboundId,
      this._pHeight,
      this._customerId,
      this._weightId,
      this._pLength,
      this._customerName);


  OutboundPackedProductDetails.fromJson(Map<String, dynamic> dataJson){
    this._name = dataJson["name"] ?? '';
    this._id = dataJson["id"];
    this._customerProjectNo = dataJson["customer_project_no"] ?? '';
    this._dimensionId = dataJson["dimension_id"];
    this._trackingNo = dataJson["tracking_no"] ?? '';
    this._orderNo = dataJson["order_no"] ?? '';
    this._pWeight = dataJson["p_weight"];
    this._pWidth = dataJson["p_width"];
    this._outboundId = dataJson["outbound_id"];
    this._pHeight = dataJson["p_height"];
    this._customerId = dataJson["customer_id"];
    this._weightId = dataJson["weight_id"];
    this._pLength = dataJson["p_length"];
    this._customerName = dataJson["customer_name"] ?? '';
  }

  String? get customerName => _customerName;

  set customerName(String? value) {
    _customerName = value;
  }

  int? get pLength => _pLength;

  set pLength(int? value) {
    _pLength = value;
  }

  int? get weightId => _weightId;

  set weightId(int? value) {
    _weightId = value;
  }

  int? get customerId => _customerId;

  set customerId(int? value) {
    _customerId = value;
  }

  int? get pHeight => _pHeight;

  set pHeight(int? value) {
    _pHeight = value;
  }

  int? get outboundId => _outboundId;

  set outboundId(int? value) {
    _outboundId = value;
  }

  int? get pWidth => _pWidth;

  set pWidth(int? value) {
    _pWidth = value;
  }

  int? get pWeight => _pWeight;

  set pWeight(int? value) {
    _pWeight = value;
  }

  String? get orderNo => _orderNo;

  set orderNo(String? value) {
    _orderNo = value;
  }

  String? get trackingNo => _trackingNo;

  set trackingNo(String? value) {
    _trackingNo = value;
  }

  int? get dimensionId => _dimensionId;

  set dimensionId(int? value) {
    _dimensionId = value;
  }

  String? get customerProjectNo => _customerProjectNo;

  set customerProjectNo(String? value) {
    _customerProjectNo = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  @override
  String toString() {
    return 'OutboundPackedProductDetails{_name: $_name, _id: $_id, _customerProjectNo: $_customerProjectNo, _dimensionId: $_dimensionId, _trackingNo: $_trackingNo, _orderNo: $_orderNo, _pWeight: $_pWeight, _pWidth: $_pWidth, _outboundId: $_outboundId, _pHeight: $_pHeight, _customerId: $_customerId, _weightId: $_weightId, _pLength: $_pLength, _customerName: $_customerName}';
  }
}