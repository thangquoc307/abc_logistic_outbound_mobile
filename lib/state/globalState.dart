import 'package:flutter/cupertino.dart';
import 'package:flutter_outbound/model/dimension.dart';
import 'package:flutter_outbound/model/location.dart';
import 'package:flutter_outbound/model/outbound.dart';
import 'package:flutter_outbound/model/outboundPackage.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/outboundPackedDto.dart';
import 'package:flutter_outbound/model/product.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/model/weight.dart';
import '../service/apiConnector.dart';
import 'package:flutter_outbound/model/outboundProductDetailDto.dart';

import '../model/outboundLocationProductDetails.dart';
import '../model/outboundProductDetails.dart';

class GlobalState extends ChangeNotifier{
  Outbound _objectForm = Outbound.nullObject();
  List<Product> productList = [];
  bool create = true;
  int _currentStep = 0;
  int _finishStep = 0;

  Map<int, String> weightUnit = {};
  Map<int, String> dimensiontUnit = {};

  String _searchkey = "";

  int pageOrderList = 0;
  int totalPageOrderList = 0;
  List<Outbound> outboundList = [];

  int pagePickList = 0;
  int totalPagePickList = 0;
  List<OutboundProductDetailDto> pickedList = [];

  int pagePackList = 0;
  int totalPagePackList = 0;
  List<OutboundPackedDto> packedList = [];

  int pageShipList = 0;
  int totalPageShipList = 0;
  List<Shipping> shippingList = [];

  GlobalState(){
    getUnit();
  }

  int countItemOutboundDisplay = 0;

  void setCountItemOutboundDisplay(BuildContext context) {
    double heightItem = 130;
    int itemOfPage = (MediaQuery.of(context).size.height / heightItem).floor();

    if (countItemOutboundDisplay == 0) {
      countItemOutboundDisplay = itemOfPage;
    }
  }

  String get searchkey => _searchkey;

  set searchkey(String value) {
    _searchkey = value;
    notifyListeners();
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
    notifyListeners();
  }

  void statePagePackList(int value) {
    pagePackList = value;
    getPackedListDatabase();
  }

  void statePagePickList(int value) {
    pagePickList = value;
    getPickedListDatabase();
  }

  void statePageOrderList(int value) {
    pageOrderList = value;
    getOrderListDatabase();
  }
  void statePageShipList(int value) {
    pageShipList = value;
    getShipListDatabase();
  }

  Future<void> getOrderListDatabase() async {
    Map<String, dynamic>? newData =
    await ApiConnector.pageSearchOutbound(pageOrderList, _searchkey, countItemOutboundDisplay);
    if (newData != null) {
      outboundList = newData["data"];
      totalPageOrderList = newData["totalPages"];
    } else {
      outboundList = [];
      totalPageOrderList = 0;
    }
    notifyListeners();
  }
  Future<void> getShipListDatabase() async {
    Map<String, dynamic>? newData =
    await ApiConnector.pageSearchShipping(pageShipList, _searchkey, countItemOutboundDisplay);
    if (newData != null) {
      shippingList = newData["data"];
      totalPageShipList = newData["totalPages"];
    } else {
      shippingList = [];
      totalPageShipList = 0;
    }
    notifyListeners();
  }
  Future<void> getPickedListDatabase() async {
    Map<String, dynamic>? newData =
    await ApiConnector.pageSearchPickedOutbound(pagePickList, _searchkey, countItemOutboundDisplay);
    if (newData != null) {
      pickedList = newData["data"];
      totalPagePickList = newData["totalPages"];
    } else {
      pickedList = [];
      totalPagePickList = 0;
    }
    notifyListeners();
  }
  Future<void> getPackedListDatabase() async {
    Map<String, dynamic>? newData =
    await ApiConnector.pageSearchPackedOutbound(pagePackList, _searchkey, countItemOutboundDisplay);
    if (newData != null) {
      packedList = newData["data"];
      totalPagePackList = newData["totalPages"];
    } else {
      packedList = [];
      totalPagePackList = 0;
    }
    notifyListeners();
  }

  Future<void> refresh(BuildContext context) async {
    pageOrderList = 0;
    pagePickList = 0;
    pagePackList = 0;
    pageShipList = 0;
    await getOrderListDatabase();
    await getPickedListDatabase();
    await getPackedListDatabase();
    await getShipListDatabase();
  }

  Future<void> getUnit() async {
    List<Weight>? weightList = await ApiConnector.getAllWeightUnit();
    if(weightList != null){
      weightList.forEach((element) {weightUnit[element.id!] = element.weightUnit!; });
    }
    List<DimensionDto>? dimensionList = await ApiConnector.getAllDimensionUnit();
    if(dimensionList != null){
      dimensionList.forEach((element) {dimensiontUnit[element.id!] = element.dimensionUnit!; });
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
            (element) => element.product!.id == productId);
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
    create = true;
    _finishStep = 0;
    _currentStep = 0;
  }
  void setupFormEdit(Outbound outbound){
    _objectForm = outbound.copyWith();
    create = false;
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
  Future<void> updateQtyPicked(OutboundProductDetail outboundProductDetail, Map<int, TextEditingController> listController, BuildContext context) async {
    List<OutboundLocationProductDetails>? list = outboundProductDetail.outboundLocationProductDetails;
    double? factor = await ApiConnector.getConvertFactor(outboundProductDetail.product!.id!);

    double mcQtyTotal = 0;
    double unitQtyTotal = 0;

    listController.forEach((key, value) {
      int unitQty = int.parse(value.text);
      double mcQty = double.parse(value.text) / factor!;

      unitQtyTotal += unitQty;
      mcQtyTotal += mcQty;

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
    outboundProductDetail.pickedUnitQty = unitQtyTotal;
    outboundProductDetail.pickedQty = mcQtyTotal;
    createOutbound(false);
  }
  OutboundLocationProductDetails? _getOutboundLocation (int locationId, List<OutboundLocationProductDetails> list){
    for (var element in list) {
      if (element.location?.id == locationId){
        return element;
      }
    }
    return null;
  }
  Future<void> createOutbound(bool isCreate) async {
    Outbound? result = await ApiConnector.createOutbound(_objectForm, isCreate);
    print(result);
    if (result != null) {
      _objectForm = result;
      await getOrderListDatabase();
      await getPickedListDatabase();
      await getPackedListDatabase();
      await getShipListDatabase();
      notifyListeners();
    }
  }
}