class ShippingAddress {
  int? _id;
  String? _addressOne;
  String? _addressTwo;
  String? _city;
  String? _state;
  String? _zipCode;
  String? _country;


  ShippingAddress.nullObject();

  ShippingAddress(this._id, this._addressOne, this._addressTwo, this._city, this._state,
      this._zipCode, this._country);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['address1'] = _addressOne;
    data['address2'] = _addressTwo;
    data['city'] = _city;
    data['state'] = _state;
    data['zipcode'] = _zipCode;
    data['country'] = _country;
    return data;
  }

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressOne = json['address1'] ?? '';
    _addressTwo = json['address2'] ?? '';
    _city = json['city'] ?? '';
    _state = json['state'] ?? '';
    _zipCode = json['zipcode'] ?? '';
    _country = json['country'] ?? '';
  }

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

  set address2(String? value) {
    _addressTwo = value;
  }

  String? get addressOne => _addressOne;

  set addressOne(String? value) {
    _addressOne = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Location{_id: $_id, _address1: $_addressOne, _address2: $_addressTwo, _city: $_city, _state: $_state, _zipcode: $_zipCode, _country: $_country}';
  }
}