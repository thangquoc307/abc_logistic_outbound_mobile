import 'dart:core';

import 'package:flutter_outbound/model/shippingAddress.dart';
import 'package:flutter_outbound/model/shippingPackage.dart';

class Shipping {
  int? _id;
  DateTime? _createdDate;
  DateTime? _lastModifiedDate;
  String? _identificationNumber;
  double? _shippingAmount;
  double? _invoiceNumber;
  DateTime? _estimatedDeliveryDate;
  String? _description;
  String? _taxNumber;
  String? _billNumber;
  String? _sender;
  String? _phoneSender;
  String? _emailSender;
  String? _phoneReceiver;
  String? _receiver;
  String? _emailReceiver;
  String? _shipmentMethod;
  String? _deliveryStatus;
  String? _carrier;
  DateTime? _shippedDate;
  Set<ShippingPackage>? _shippingPackages;
  ShippingAddress? _shipToAddress;
  ShippingAddress? _shipFromAddress;

  Shipping(
      this._id,
      this._createdDate,
      this._lastModifiedDate,
      this._identificationNumber,
      this._shippingAmount,
      this._invoiceNumber,
      this._estimatedDeliveryDate,
      this._description,
      this._taxNumber,
      this._billNumber,
      this._sender,
      this._phoneSender,
      this._emailSender,
      this._phoneReceiver,
      this._receiver,
      this._emailReceiver,
      this._shipmentMethod,
      this._deliveryStatus,
      this._carrier,
      this._shippedDate,
      this._shippingPackages,
      this._shipToAddress,
      this._shipFromAddress);

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['createdDate'] = this._createdDate != null ?
    this._createdDate!.millisecondsSinceEpoch : null;
    data['lastModifiedDate'] = this._lastModifiedDate != null ?
    this._lastModifiedDate!.millisecondsSinceEpoch : null;
    data['identificationNumber'] = _identificationNumber;
    data['shippingAmount'] = _shippingAmount;
    data['invoiceNumber'] = _invoiceNumber;
    data['estimatedDeliveryDate'] = this._estimatedDeliveryDate != null ?
    this._estimatedDeliveryDate!.millisecondsSinceEpoch : null;
    data['description'] = _description;
    data['taxNumber'] = _taxNumber;
    data['billNumber'] = _billNumber;
    data['sender'] = _sender;
    data['phoneSender'] = _phoneSender;
    data['emailSender'] = _emailSender;
    data['phoneReceiver'] = _phoneReceiver;
    data['receiver'] = _receiver;
    data['emailReceiver'] = _emailReceiver;
    data['shipmentMethod'] = _shipmentMethod;
    data['deliveryStatus'] = _deliveryStatus;
    data['carrier'] = _carrier;
    data['shippedDate'] = this._shippedDate != null ?
    this._shippedDate!.millisecondsSinceEpoch : null;
    data['shippingPackages'] = _shippingPackages?.map((package) => package.toJson())?.toList();
    data['shipToAddress'] = _shipToAddress?.toJson();
    data['shipFromAddress'] = _shipFromAddress?.toJson();
    return data;
  }

  Shipping.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int?;
    _createdDate = json['createdDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
        : null;
    _lastModifiedDate = json['lastModifiedDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['lastModifiedDate'])
        : null;
    _identificationNumber = json['identificationNumber'] ?? '';
    _shippingAmount = json['shippingAmount'] as double?;
    _invoiceNumber = json['invoiceNumber'] as double?;
    _estimatedDeliveryDate = json['estimatedDeliveryDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['estimatedDeliveryDate'])
        : null;
    _description = json['description'] ?? '';
    _taxNumber = json['taxNumber'] ?? '';
    _billNumber = json['billNumber'] ?? '';
    _sender = json['sender'] ?? '';
    _phoneSender = json['phoneSender'] ?? '';
    _emailSender = json['emailSender'] ?? '';
    _phoneReceiver = json['phoneReceiver'] ?? '';
    _receiver = json['receiver'] ?? '';
    _emailReceiver = json['emailReceiver'] ?? '';
    _shipmentMethod = json['shipmentMethod'] ?? '';
    _deliveryStatus = json['deliveryStatus'] ?? '';
    _carrier = json['carrier'] ?? '';
    _shippedDate = json['shippedDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['shippedDate'])
        : null;

    if (json.containsKey('shippingPackages')) {
      var shippingPackagesList = json['shippingPackages'] as List;
      _shippingPackages = shippingPackagesList
          .map((item) => ShippingPackage.fromJson(item))
          .toSet();
    } else {
      _shippingPackages = null;
    }

    _shipToAddress = json.containsKey('shipToAddress')
        ? ShippingAddress.fromJson(json['shipToAddress'])
        : null;
    _shipFromAddress = json.containsKey('shipFromAddress')
        ? ShippingAddress.fromJson(json['shipFromAddress'])
        : null;
  }

  ShippingAddress? get shipFromAddress => _shipFromAddress;

  set shipFromAddress(ShippingAddress? value) {
    _shipFromAddress = value;
  }

  ShippingAddress? get shipToAddress => _shipToAddress;

  set shipToAddress(ShippingAddress? value) {
    _shipToAddress = value;
  }

  Set<ShippingPackage>? get shippingPackages => _shippingPackages;

  set shippingPackages(Set<ShippingPackage>? value) {
    _shippingPackages = value;
  }

  DateTime? get shippedDate => _shippedDate;

  set shippedDate(DateTime? value) {
    _shippedDate = value;
  }

  String? get carrier => _carrier;

  set carrier(String? value) {
    _carrier = value;
  }

  String? get deliveryStatus => _deliveryStatus;

  set deliveryStatus(String? value) {
    _deliveryStatus = value;
  }

  String? get shipmentMethod => _shipmentMethod;

  set shipmentMethod(String? value) {
    _shipmentMethod = value;
  }

  String? get emailReceiver => _emailReceiver;

  set emailReceiver(String? value) {
    _emailReceiver = value;
  }

  String? get receiver => _receiver;

  set receiver(String? value) {
    _receiver = value;
  }

  String? get phoneReceiver => _phoneReceiver;

  set phoneReceiver(String? value) {
    _phoneReceiver = value;
  }

  String? get emailSender => _emailSender;

  set emailSender(String? value) {
    _emailSender = value;
  }

  String? get phoneSender => _phoneSender;

  set phoneSender(String? value) {
    _phoneSender = value;
  }

  String? get sender => _sender;

  set sender(String? value) {
    _sender = value;
  }

  String? get billNumber => _billNumber;

  set billNumber(String? value) {
    _billNumber = value;
  }

  String? get taxNumber => _taxNumber;

  set taxNumber(String? value) {
    _taxNumber = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  DateTime? get estimatedDeliveryDate => _estimatedDeliveryDate;

  set estimatedDeliveryDate(DateTime? value) {
    _estimatedDeliveryDate = value;
  }

  double? get invoiceNumber => _invoiceNumber;

  set invoiceNumber(double? value) {
    _invoiceNumber = value;
  }

  double? get shippingAmount => _shippingAmount;

  set shippingAmount(double? value) {
    _shippingAmount = value;
  }

  String? get identificationNumber => _identificationNumber;

  set identificationNumber(String? value) {
    _identificationNumber = value;
  }

  DateTime? get lastModifiedDate => _lastModifiedDate;

  set lastModifiedDate(DateTime? value) {
    _lastModifiedDate = value;
  }

  DateTime? get createdDate => _createdDate;

  set createdDate(DateTime? value) {
    _createdDate = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Shipping{_id: $_id, _createdDate: $_createdDate, _lastModifiedDate: $_lastModifiedDate, _identificationNumber: $_identificationNumber, _shippingAmount: $_shippingAmount, _invoiceNumber: $_invoiceNumber, _estimatedDeliveryDate: $_estimatedDeliveryDate, _description: $_description, _taxNumber: $_taxNumber, _billNumber: $_billNumber, _sender: $_sender, _phoneSender: $_phoneSender, _emailSender: $_emailSender, _phoneReceiver: $_phoneReceiver, _receiver: $_receiver, _emailReceiver: $_emailReceiver, _shipmentMethod: $_shipmentMethod, _deliveryStatus: $_deliveryStatus, _carrier: $_carrier, _shippedDate: $_shippedDate, _shippingPackages: $_shippingPackages, _shipToAddress: $_shipToAddress, _shipFromAddress: $_shipFromAddress}';
  }
}