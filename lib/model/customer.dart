import 'billing.dart';

class Customer {
  int? _customerId;
  String? _customerNo;
  String? _customerName;
  Billing? _billing;

  Customer(this._customerId, this._customerNo, this._customerName, this._billing);

  Customer.nullObject();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['customerId'] = _customerId;
    data['customerNo'] = _customerNo;
    data['customerName'] = _customerName;
    if (_billing != null) {
      data['billing'] = _billing!.toJson();
    }
    return data;
  }
  Customer.fromJson(Map<String, dynamic> json) {
    _customerId = json['customerId'];
    _customerNo = json['customerNo'] ?? '';
    _customerName = json['customerName'] ?? '';
    _billing = json.containsKey('billing') ? Billing.fromJson(json['billing']) : null;
  }

  String? get customerName => _customerName;

  set customerName(String? value) {
    _customerName = value;
  }

  String? get customerNo => _customerNo;

  set customerNo(String? value) {
    _customerNo = value;
  }

  int? get customerId => _customerId;

  set customerId(int? value) {
    _customerId = value;
  }


  Billing? get billing => _billing;

  set billing(Billing? value) {
    _billing = value;
  }

  @override
  String toString() {
    return 'Customer{_customerId: $_customerId, _customerNo: $_customerNo, _customerName: $_customerName, _billing: $_billing}';
  }

}
