class Billing {
  int? _billingId;
  String? _name;
  String? _addressOne;
  String? _addressTwo;
  String? _city;
  String? _state;
  String? _zipCode;
  String? _country;


  Billing.nullObject();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['billingId'] = _billingId;
    data['name'] = _name;
    data['addressOne'] = _addressOne;
    data['addressTwo'] = _addressTwo;
    data['city'] = _city;
    data['state'] = _state;
    data['zipCode'] = _zipCode;
    data['country'] = _country;
    return data;
  }

  Billing.fromJson(Map<String, dynamic> json) {
    _billingId = json['billingId'];
    _name = json['name'] ?? '';
    _addressOne = json['addressOne'] ?? '';
    _addressTwo = json['addressTwo'] ?? '';
    _city = json['city'] ?? '';
    _state = json['state'] ?? '';
    _zipCode = json['zipCode'] ?? '';
    _country = json['country'] ?? '';
  }

  Billing(this._billingId, this._name, this._addressOne, this._addressTwo,
      this._city, this._state, this._zipCode, this._country);

  String? get country => _country;

  set country(String? value) {
    _country = value;
  }

  String? get zipCode => _zipCode;

  set zipCode(String? value) {
    _zipCode = value;
  }

  String? get state => _state;

  set state(String? value) {
    _state = value;
  }

  String? get city => _city;

  set city(String? value) {
    _city = value;
  }

  String? get addressTwo => _addressTwo;

  set addressTwo(String? value) {
    _addressTwo = value;
  }

  String? get addressOne => _addressOne;

  set addressOne(String? value) {
    _addressOne = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get billingId => _billingId;

  set billingId(int? value) {
    _billingId = value;
  }

  @override
  String toString() {
    return 'Billing{_billingId: $_billingId, _name: $_name, _addressOne: $_addressOne, _addressTwo: $_addressTwo, _city: $_city, _state: $_state, _zipCode: $_zipCode, _country: $_country}';
  }
}