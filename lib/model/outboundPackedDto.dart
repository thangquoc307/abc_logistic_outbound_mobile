class OutboundPackedDto {
  String? _name;
  int? _id;
  num? _pLength;
  num? _pHeight;
  num? _pWeight;
  num? _pWidth;
  String? _trackingNo;
  int? _dimensionId;
  int? _outboundId;
  int? _weightId;
  int? _customerId;
  String? _customerName;
  String? _orderNo;
  String? _customerProjectNo;

  OutboundPackedDto.fromJson(Map<String, dynamic> json) {
    this._name = json['name'] ?? '';
    this._id = json['id'] ?? -1;
    this._pLength = json['p_length'] ?? -1;
    this._pHeight = json['p_height'] ?? -1;
    this._pWeight = json['p_weight'] ?? -1;
    this._pWidth = json['p_width'] ?? -1;
    this._trackingNo = json['tracking_no'] ?? '';
    this._dimensionId = json['dimension_id'] ?? -1;
    this._outboundId = json['outbound_id'] ?? -1;
    this._weightId = json['weight_id'] ?? -1;
    this._customerId = json['customer_id'] ?? -1;
    this._customerName = json['customer_name'] ?? '';
    this._orderNo = json['order_no'] ?? '';
    this._customerProjectNo = json['customer_project_no'] ?? '';
  }

  OutboundPackedDto(
      this._name,
      this._id,
      this._pLength,
      this._pHeight,
      this._pWeight,
      this._pWidth,
      this._trackingNo,
      this._dimensionId,
      this._outboundId,
      this._weightId,
      this._customerId,
      this._customerName,
      this._orderNo,
      this._customerProjectNo);

  String? get customerProjectNo => _customerProjectNo;

  set customerProjectNo(String? value) {
    _customerProjectNo = value;
  }

  String? get orderNo => _orderNo;

  set orderNo(String? value) {
    _orderNo = value;
  }

  String? get customerName => _customerName;

  set customerName(String? value) {
    _customerName = value;
  }

  int? get customerId => _customerId;

  set customerId(int? value) {
    _customerId = value;
  }

  int? get weightId => _weightId;

  set weightId(int? value) {
    _weightId = value;
  }

  int? get outboundId => _outboundId;

  set outboundId(int? value) {
    _outboundId = value;
  }

  int? get dimensionId => _dimensionId;

  set dimensionId(int? value) {
    _dimensionId = value;
  }

  String? get trackingNo => _trackingNo;

  set trackingNo(String? value) {
    _trackingNo = value;
  }

  num? get pWidth => _pWidth;

  set pWidth(num? value) {
    _pWidth = value;
  }

  num? get pWeight => _pWeight;

  set pWeight(num? value) {
    _pWeight = value;
  }

  num? get pHeight => _pHeight;

  set pHeight(num? value) {
    _pHeight = value;
  }

  num? get pLength => _pLength;

  set pLength(num? value) {
    _pLength = value;
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
    return 'OutboundPackedDto{_name: $_name, _id: $_id, _pLength: $_pLength, _pHeight: $_pHeight, _pWeight: $_pWeight, _pWidth: $_pWidth, _trackingNo: $_trackingNo, _dimensionId: $_dimensionId, _outboundId: $_outboundId, _weightId: $_weightId, _customerId: $_customerId, _customerName: $_customerName, _orderNo: $_orderNo, _customerProjectNo: $_customerProjectNo}';
  }
}