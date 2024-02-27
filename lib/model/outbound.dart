import 'package:flutter_outbound/model/billing.dart';
import 'package:flutter_outbound/model/customer.dart';
import 'package:flutter_outbound/model/outboundPackage.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/model/shippingAddress.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';

class Outbound {
  num? _id;
  String? _orderNo;
  String? _customerProjectNo;
  DateTime? _createdDate;
  DateTime? _lastModifiedDate;
  num? _totalItems;
  num? _totalPicked;
  num? _totalPackaged;
  num? _totalShipped;
  num? _completed;
  String? _sender;
  String? _receiver;
  String? _store;
  String? _channel;
  String? _issuser;
  Customer? _customer;
  Billing? _billing;
  ShippingAddress? _shipFromAddress;
  ShippingAddress? _shipToAddress;
  DateTime? _etd;
  DateTime? _eta;
  Set<OutboundProductDetail>? _outboundProductDetails;
  Set<OutboundPackage>? _outboundPackages;
  Set<Shipping>? _shippings;
  String? _note;
  String? _status;
  String? _shipType;

  Outbound(
      this._id,
      this._orderNo,
      this._customerProjectNo,
      this._createdDate,
      this._lastModifiedDate,
      this._totalItems,
      this._totalPicked,
      this._totalPackaged,
      this._totalShipped,
      this._completed,
      this._sender,
      this._receiver,
      this._store,
      this._channel,
      this._issuser,
      this._customer,
      this._billing,
      this._shipFromAddress,
      this._shipToAddress,
      this._etd,
      this._eta,
      this._outboundProductDetails,
      this._outboundPackages,
      this._shippings,
      this._note,
      this._status,
      this._shipType);

  Outbound.nullObject() {
    _customer = Customer.nullObject();
    _billing = Billing.nullObject();
    _shipFromAddress = ShippingAddress.nullObject();
    _shipToAddress = ShippingAddress.nullObject();
    _outboundPackages = {};
    _outboundProductDetails = {};
    _shippings = {};
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['orderNo'] = this._orderNo;
    data['customerProjectNo'] = this._customerProjectNo;
    data['createdDate'] = this._createdDate != null ?
    this._createdDate!.millisecondsSinceEpoch : null;
    data['lastModifiedDate'] = this._lastModifiedDate != null ?
    this._lastModifiedDate!.millisecondsSinceEpoch : null;
    data['totalItems'] = this._totalItems;
    data['totalPicked'] = this._totalPicked;
    data['totalPackaged'] = this._totalPackaged;
    data['totalShipped'] = this._totalShipped;
    data['completed'] = this._completed;
    data['sender'] = this._sender;
    data['receiver'] = this._receiver;
    data['store'] = this._store;
    data['channel'] = this._channel;
    data['issuser'] = this._issuser;
    data['customer'] = this._customer?.toJson();
    data['billing'] = this._billing?.toJson();
    data['shipFromAddress'] = this._shipFromAddress?.toJson();
    data['shipToAddress'] = this._shipToAddress?.toJson();
    data['etd'] = this._etd != null ? this._etd!.millisecondsSinceEpoch : null;
    data['eta'] = this._eta != null ? this._eta!.millisecondsSinceEpoch : null;
    data['outboundProductDetails'] = this._outboundProductDetails
        ?.map((detail) => detail.toJson())
        ?.toList();
    data['outboundPackages'] = this._outboundPackages
        ?.map((packages) => packages.toJson())
        ?.toList();
    data['shippings'] = this._shippings
        ?.map((shipping) => shipping.toJson())
        ?.toList();
    data['note'] = this._note;
    data['status'] = this._status;
    data['shipType'] = this._shipType;
    return data;
  }

  Outbound.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderNo = json['orderNo'] ?? '';
    _customerProjectNo = json['customerProjectNo'] ?? '';
    _createdDate = json['createdDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
        : null;
    _lastModifiedDate = json['lastModifiedDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['lastModifiedDate'])
        : null;
    _totalItems = json['totalItems'];
    _totalPicked = json['totalPicked'];
    _totalPackaged = json['totalPackaged'];
    _totalShipped = json['totalShipped'];
    _completed = json['completed'];
    _sender = json['sender'] ?? '';
    _receiver = json['receiver'] ?? '';
    _store = json['store'] ?? '';
    _channel = json['channel'] ?? '';
    _issuser = json['issuser'] ?? '';
    _shipType = json['shipType'];
    _billing = json.containsKey('billing') ? Billing.fromJson(json['billing']) : null;
    _shipFromAddress = json.containsKey('shipFromAddress') ? ShippingAddress.fromJson(json['shipFromAddress']) : null;
    _shipToAddress = json.containsKey('shipToAddress') ? ShippingAddress.fromJson(json['shipToAddress']) : null;
    _customer = json.containsKey('customer') ? Customer.fromJson(json['customer']) : null;
    _etd = json['etd'] != null ? DateTime.fromMillisecondsSinceEpoch(json['etd']) : null;
    _eta = json['eta'] != null ? DateTime.fromMillisecondsSinceEpoch(json['eta']) : null;

    if (json.containsKey('outboundProductDetails')) {
      var outboundProductDetailsList = json['outboundProductDetails'] as List;
      _outboundProductDetails = outboundProductDetailsList
          .map((item) => OutboundProductDetail.fromJson(item))
          .toSet();
    } else {
      _outboundProductDetails = {};
    }
    if (json.containsKey('outboundPackages')) {
      var outboundPackagesList = json['outboundPackages'] as List;
      _outboundPackages = outboundPackagesList
          .map((item) => OutboundPackage.fromJson(item))
          .toSet();
    } else {
      _outboundPackages = {};
    }

    if (json.containsKey('shippings')) {
      var shippingsList = json['shippings'] as List;
      _shippings = shippingsList
          .map((item) => Shipping.fromJson(item))
          .toSet();
    } else {
      _shippings = {};
    }

    _note = json['note'] ?? '';
    _status = json['status'] ?? '';
  }

  String? get status => _status;

  set status(String? value) {
    _status = value;
  }

  String? get note => _note;

  set note(String? value) {
    _note = value;
  }

  Set<Shipping>? get shippings => _shippings;

  set shippings(Set<Shipping>? value) {
    _shippings = value;
  }

  Set<OutboundProductDetail>? get outboundProductDetails =>
      _outboundProductDetails;

  set outboundProductDetails(Set<OutboundProductDetail>? value) {
    _outboundProductDetails = value;
  }

  DateTime? get eta => _eta;

  set eta(DateTime? value) {
    _eta = value;
  }

  DateTime? get etd => _etd;

  set etd(DateTime? value) {
    _etd = value;
  }

  ShippingAddress? get shipToAddress => _shipToAddress;

  set shipToAddress(ShippingAddress? value) {
    _shipToAddress = value;
  }

  ShippingAddress? get shipFromAddress => _shipFromAddress;

  set shipFromAddress(ShippingAddress? value) {
    _shipFromAddress = value;
  }

  Billing? get billing => _billing;

  set billing(Billing? value) {
    _billing = value;
  }

  Customer? get customer => _customer;

  set customer(Customer? value) {
    _customer = value;
  }

  String? get issuser => _issuser;

  set issuser(String? value) {
    _issuser = value;
  }

  String? get channel => _channel;

  set channel(String? value) {
    _channel = value;
  }

  String? get store => _store;

  set store(String? value) {
    _store = value;
  }

  String? get receiver => _receiver;

  set receiver(String? value) {
    _receiver = value;
  }

  String? get sender => _sender;

  set sender(String? value) {
    _sender = value;
  }

  num? get completed => _completed;

  set completed(num? value) {
    _completed = value;
  }

  num? get totalShipped => _totalShipped;

  set totalShipped(num? value) {
    _totalShipped = value;
  }

  num? get totalPackaged => _totalPackaged;

  set totalPackaged(num? value) {
    _totalPackaged = value;
  }

  num? get totalPicked => _totalPicked;

  set totalPicked(num? value) {
    _totalPicked = value;
  }

  num? get totalItems => _totalItems;

  set totalItems(num? value) {
    _totalItems = value;
  }

  DateTime? get lastModifiedDate => _lastModifiedDate;

  set lastModifiedDate(DateTime? value) {
    _lastModifiedDate = value;
  }

  DateTime? get createdDate => _createdDate;

  set createdDate(DateTime? value) {
    _createdDate = value;
  }

  String? get customerProjectNo => _customerProjectNo;

  set customerProjectNo(String? value) {
    _customerProjectNo = value;
  }

  String? get orderNo => _orderNo;

  set orderNo(String? value) {
    _orderNo = value;
  }

  num? get id => _id;

  set id(num? value) {
    _id = value;
  }

  Set<OutboundPackage>? get outboundPackages => _outboundPackages;

  set outboundPackages(Set<OutboundPackage>? value) {
    _outboundPackages = value;
  }

  Outbound copyWith() {
    return Outbound(
        this._id,
        this._orderNo,
        this._customerProjectNo,
        this._createdDate,
        this._lastModifiedDate,
        this._totalItems,
        this._totalPicked,
        this._totalPackaged,
        this._totalShipped,
        this._completed,
        this._sender,
        this._receiver,
        this._store,
        this._channel,
        this._issuser,
        this._customer,
        this._billing,
        this._shipFromAddress,
        this._shipToAddress,
        this._etd,
        this._eta,
        this._outboundProductDetails,
        this._outboundPackages,
        this._shippings,
        this._note,
        this._status,
        this._shipType);
  }

  String? get shipType => _shipType;

  set shipType(String? value) {
    _shipType = value;
  }

  @override
  String toString() {
    return 'Outbound{_id: $_id, _orderNo: $_orderNo, _customerProjectNo: $_customerProjectNo, _createdDate: $_createdDate, _lastModifiedDate: $_lastModifiedDate, _totalItems: $_totalItems, _totalPicked: $_totalPicked, _totalPackaged: $_totalPackaged, _totalShipped: $_totalShipped, _completed: $_completed, _sender: $_sender, _receiver: $_receiver, _store: $_store, _channel: $_channel, _issuser: $_issuser, _customer: $_customer, _billing: $_billing, _shipFromAddress: $_shipFromAddress, _shipToAddress: $_shipToAddress, _etd: $_etd, _eta: $_eta, _outboundProductDetails: $_outboundProductDetails, _outboundPackages: $_outboundPackages, _shippings: $_shippings, _note: $_note, _status: $_status, _shipType: $_shipType}';
  }
}