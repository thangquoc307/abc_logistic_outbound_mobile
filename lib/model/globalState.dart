import 'package:flutter/cupertino.dart';
import 'package:flutter_outbound/model/dimension.dart';
import 'package:flutter_outbound/model/location.dart';
import 'package:flutter_outbound/model/outbound.dart';
import 'package:flutter_outbound/model/outboundPackage.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/outboundPackedDto.dart';
import 'package:flutter_outbound/model/product.dart';
import 'package:flutter_outbound/model/weight.dart';
import '../service/apiConnector.dart';
import 'package:flutter_outbound/model/outboundProductDetailDto.dart';

import 'outboundLocationProductDetails.dart';
import 'outboundProductDetails.dart';

class GlobalState extends ChangeNotifier{
  Outbound _objectForm = Outbound.nullObject();
  List<Product> productList = [];
  bool _create = true;
  int _currentStep = 0;
  int _finishStep = 0;

  Map<int, String> _weightUnit = {};
  Map<int, String> _dimensiontUnit = {};

  String _searchkey = "";

  int _pageOrderList = 0;
  int _totalPageOrderList = 0;
  List<Outbound> outboundList = [];

  int _pagePickList = 0;
  int _totalPagePickList = 0;
  List<OutboundProductDetailDto> pickedList = [];

  int _pagePackList = 0;
  int _totalPagePackList = 0;
  List<OutboundPackedDto> packedList = [];

  int _pageShipList = 0;
  int _totalPageShipList = 0;
  List<Outbound> shippingList = [];

  GlobalState(){
    getUnit();
  }


  Map<int, double> getUnfulfilledQty() {
    Map<int, double> result = {};
    if(_objectForm != null){
      Set<OutboundPackage> setPackage = _objectForm.outboundPackages!;
      for (var element in setPackage) {
        Set<OutboundPackageProductDetail> setOutboundPackage = element.outboundPackageProductDetails!;
        for (var package in setOutboundPackage) {
          int id = package.product!.id!;
          double oldValue =  result[id] ?? 0;
          result[id] = (oldValue + package.packagedQty!);
        }
      }
    }
    return result;
  }

  bool get create => _create;

  set create(bool value) {
    _create = value;
    notifyListeners();
  }

  int get finishStep => _finishStep;

  set finishStep(int value) {
    _finishStep = value;
    notifyListeners();
  }

  int get currentStep => _currentStep;

  set currentStep(int value) {
    if(value <= _finishStep){
      _currentStep = value;
      notifyListeners();
    }
  }


  Outbound get objectForm => _objectForm;

  set objectForm(Outbound value) {
    _objectForm = value;
  }

  String get searchkey => _searchkey;

  set searchkey(String value) {
    _searchkey = value;
  }

  int get totalPageShipList => _totalPageShipList;

  set totalPageShipList(int value) {
    _totalPageShipList = value;
    notifyListeners();
  }

  int get pageShipList => _pageShipList;

  set pageShipList(int value) {
    _pageShipList = value;

  }

  int get totalPagePackList => _totalPagePackList;

  set totalPagePackList(int value) {
    _totalPagePackList = value;
    notifyListeners();
  }

  int get pagePackList => _pagePackList;

  void statePagePackList(int value, BuildContext context) {
    _pagePackList = value;
    getPackedListDatabase(context);
  }

  int get totalPagePickList => _totalPagePickList;

  set totalPagePickList(int value) {
    _totalPagePickList = value;
    notifyListeners();
  }

  int get pagePickList => _pagePickList;

  void statePagePickList(int value, BuildContext context) {
    _pagePickList = value;
    getPickedListDatabase(context);
  }

  int get totalPageOrderList => _totalPageOrderList;

  set totalPageOrderList(int value) {
    _totalPageOrderList = value;
    notifyListeners();
  }

  int get pageOrderList => _pageOrderList;

  void statePageOrderList(int value, BuildContext context) {
    _pageOrderList = value;
    getOrderListDatabase(context);
  }


  Map<int, String> get weightUnit => _weightUnit;

  set weightUnit(Map<int, String> value) {
    _weightUnit = value;
  }

  Map<int, String> get dimensiontUnit => _dimensiontUnit;

  set dimensiontUnit(Map<int, String> value) {
    _dimensiontUnit = value;
  }

  Future<void> getOrderListDatabase(BuildContext context) async {
    Map<String, dynamic>? newData = await ApiConnector.pageSearchOutbound(_pageOrderList, _searchkey, context);
    if (newData != null) {
      outboundList = newData["data"];
      _totalPageOrderList = newData["totalPages"];
    } else {
      outboundList = [];
      _totalPageOrderList = 0;
    }
    notifyListeners();
  }
  Future<void> getPickedListDatabase(BuildContext context) async {
    Map<String, dynamic>? newData = await ApiConnector.pageSearchPickedOutbound(_pagePickList, _searchkey, context);
    if (newData != null) {
      pickedList = newData["data"];
      _totalPagePickList = newData["totalPages"];
    } else {
      pickedList = [];
      _totalPagePickList = 0;
    }
    notifyListeners();
  }
  Future<void> getPackedListDatabase(BuildContext context) async {
    Map<String, dynamic>? newData = await ApiConnector.pageSearchPackedOutbound(_pagePackList, _searchkey, context);
    if (newData != null) {
      packedList = newData["data"];
      _totalPagePackList = newData["totalPages"];
    } else {
      packedList = [];
      _totalPagePackList = 0;
    }
    notifyListeners();
  }

  Future<void> search(BuildContext context) async {
    _pageOrderList = 0;
    _pagePickList = 0;
    _pagePackList = 0;
    _pageShipList = 0;
    await getOrderListDatabase(context);
    await getPickedListDatabase(context);
    await getPackedListDatabase(context);
  }

  Future<void> getUnit() async {
    List<Weight>? weightList = await ApiConnector.getAllWeightUnit();
    if(weightList != null){
      weightList.forEach((element) {_weightUnit[element.id!] = element.weightUnit!; });
    }
    List<DimensionDto>? dimensionList = await ApiConnector.getAllDimensionUnit();
    if(dimensionList != null){
      dimensionList.forEach((element) {_dimensiontUnit[element.id!] = element.dimensionUnit!; });
    }
    notifyListeners();
  }

  Future<void> getProductByCustomerId(int? customerId) async {
    List<Product>? res = await ApiConnector.getProductByCustomerId(customerId!);
    if(res != null){
      productList = res;
      notifyListeners();
    }
  }

  void editRequestedQty(int? productId, double newMCQty, double newUnitQty) {
    OutboundProductDetail? target = objectForm.outboundProductDetails?.firstWhere(
            (element) => element.id == productId);
    target?.requestedQty = newMCQty;
    target?.requestedUnitQty = newUnitQty;
    notifyListeners();
  }

  void addRequestProduct(Product product) {
    OutboundProductDetail newOutboundProduct = OutboundProductDetail(
        null, 0, 0, 0, product, [], 0, 0, 0, 0, 0, 0, 0, product.skus?[0].name
    );
    objectForm.outboundProductDetails?.add(newOutboundProduct);
    notifyListeners();
  }
  void delRequestProduct(Product product) {
    objectForm.outboundProductDetails?.removeWhere((element) => element.product?.id == product.id);
    notifyListeners();
  }
  void setupFormCreate(){
    _objectForm = Outbound.nullObject();
    _create = true;
    _finishStep = 0;
    _currentStep = 0;
  }
  void setupFormEdit(Outbound outbound){
    _objectForm = outbound.copyWith();
    _create = false;
    int initStep;

    if (outbound.totalShipped! > 0){
      initStep = 4;
    } else if (outbound.totalPackaged! > 0){
      initStep = 3;
    } else if (outbound.totalPicked! > 0){
      initStep = 2;
    } else {
      initStep = 1;
    }
    _finishStep = initStep;
    _currentStep = initStep;
  }
  Future<void> updateQtyPicked(OutboundProductDetail outboundProductDetail, Map<int, TextEditingController> listController) async {
    List<OutboundLocationProductDetails>? list = outboundProductDetail.outboundLocationProductDetails;
    double? factor = await ApiConnector.getConvertFactor(outboundProductDetail.product!.id!);

    listController.forEach((key, value) {
      int unitQty = int.parse(value.text);
      double mcQty = double.parse(value.text) / factor!;

      OutboundLocationProductDetails? locationProductDetails = _getOutboundLocation(key, list!);
      if(locationProductDetails != null){
        locationProductDetails.pickedUnitQty = unitQty;
        locationProductDetails.pickedQty = mcQty;
      } else {
        Location location = Location(id: key, locationNo: null);
        OutboundLocationProductDetails outboundLocationProductDetails = OutboundLocationProductDetails(
            id: null, location: location, pickedQty: mcQty, pickedUnitQty: unitQty);
        list.add(outboundLocationProductDetails);
      }
    });

    Outbound? callBackObject = await ApiConnector.createOutbound(_objectForm, false);
    if (callBackObject != null){
      _objectForm = callBackObject;
    }
    notifyListeners();
  }
  OutboundLocationProductDetails? _getOutboundLocation (int locationId, List<OutboundLocationProductDetails> list){
    for (var element in list) {
      if (element.location?.id == locationId){
        return element;
      }
    }
    return null;
  }
}