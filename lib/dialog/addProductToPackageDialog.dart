import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/cascadeStyle/image.dart';
import 'package:flutter_outbound/model/dimension.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';
import 'package:flutter_outbound/model/product.dart';
import 'package:flutter_outbound/model/weight.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:flutter_outbound/service/stepRender.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';
import '../model/outboundPackage.dart';

class AddProductToPackageDialog extends StatefulWidget {
  const AddProductToPackageDialog({super.key, required this.outboundPackage, required this.outboundProductDetail});
  final OutboundPackage outboundPackage;
  final Set<OutboundProductDetail> outboundProductDetail;

  @override
  State<AddProductToPackageDialog> createState() => _AddProductToPackageState();
}

class _AddProductToPackageState extends State<AddProductToPackageDialog> {
  int step = 0;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  Map<int, OutboundPackageProductDetail> mapResult = {};
  Map<int, double> mapFactor = {};
  String searchKey = "";

  @override
  void initState() {
    super.initState();
    getFactor();
  }

  Future<void> getFactor() async {
    for (var element in widget.outboundProductDetail) {
      int id = element.product!.id!;
      double? factor = await ApiConnector.getConvertFactor(id);
      mapFactor[id] = factor ?? 1;
    }
  }

  String? _dimensionValueValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Dimension is required';
    }
    RegExp regex = RegExp(r'^[0-9]+(\.[0-9]+)?x[0-9]+(\.[0-9]+)?x[0-9]+(\.[0-9]+)?$');
    if (!regex.hasMatch(value)){
      return 'Format width x height x length';
    }
    List<double> dimensionList = _analDimension(value);
    if (dimensionList[0] == 0 || dimensionList[1] == 0 || dimensionList[2] == 0) {
      return 'Dimension not equal 0';
    }
    return null;
  }
  String? _weightValueValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }
    double weight = double.parse(value);
    if (weight <= 0) {
      return 'Weight over than 0';
    }
    return null;
  }

  OutboundPackageProductDetail _getOldPackage(Product product) {
    Set<OutboundPackageProductDetail> listPackage = widget.outboundPackage.outboundPackageProductDetails!;
    for (var element in listPackage) {
      if (element.product!.id == product.id) {
        return element;
      }
    }
    return OutboundPackageProductDetail(null, 0, product, 0, product.skus?[0].name);
  }

  List<double> _analDimension(String value) {
    value = value.replaceAll(" ", "");
    List<String> strList = value.split("x");

    return [double.parse(strList[0]), double.parse(strList[1]), double.parse(strList[2])];
  }

  String? _checkPackageQty(String? value, double unfulfilled, double oldValue){
    if (value == null || value.isEmpty) {
      return 'Qty is required';
    }
    double qty = double.parse(value);
    if (qty - oldValue > unfulfilled) {
      return 'Over qty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GlobalState>(context, listen: true);
    Map<int, double> unfulfilledQty = state.getUnfulfilledQty();

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("ADD PRODUCTS TO PACKAGE",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (step == 0) {
              Navigator.of(context).pop();
            } else {
              setState(() {step = 0;});
            }
          },
          child: Text((step == 0) ? "Cancel" : "Back", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if (step == 1) {
              if (_formKey2.currentState!.validate()){
                Set<OutboundPackageProductDetail> setPack = {};
                for (var element in mapResult.entries) {
                  if (element.value.packagedQty! > 0 || element.value.id != null){
                    setPack.add(element.value);
                  }
                }
                widget.outboundPackage.outboundPackageProductDetails = setPack;

                if (widget.outboundPackage.id == null){
                  state.objectForm.outboundPackages!.add(widget.outboundPackage);
                } else {
                  for (var element in state.objectForm.outboundPackages!) {
                    if (element.id == widget.outboundPackage.id){
                      element = widget.outboundPackage;
                    }
                  }
                }
                state.createOutbound(false);
                Navigator.of(context).pop();
              }
            } else {
              if (_formKey1.currentState!.validate()){
                setState(() {step = 1;});
              }
            }
          },
          child: Text((step == 0) ? "Next" : "Save", style: TextStyleMobile.h1_14
              .copyWith(color: MobileColor.orangeColor)),
        ),
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,),
            StepRenderCustom.stepRender(["Information", "Add prod"], step, context),
            InputStyle.offsetForm,
            Expanded(
              child: SingleChildScrollView(
                child: step == 0
                  ? Form(
                key: _formKey1,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Package name",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      TextFormField(
                        initialValue: widget.outboundPackage.name,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        readOnly: true,
                      ),
                      InputStyle.offsetForm,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Tracking no.",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      TextFormField(
                        initialValue: widget.outboundPackage.trackingNo,
                        validator: (value) => Utils.validateRequire(value, "Tracking no."),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        onChanged: (value) {
                          widget.outboundPackage.trackingNo = value;
                        },
                      ),
                      InputStyle.offsetForm,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Unit of Dimension",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      DropdownButtonFormField<int>(
                        value: widget.outboundPackage.dimension?.id,
                        hint: const Text("Select Dimension Unit"),
                        decoration: InputStyle.inputTextForm,
                        items: state.dimensiontUnit.entries.map((MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                        validator: (value) => Utils.validateRequire(value.toString(), "Dimension unit"),
                        onChanged: (value) {
                          widget.outboundPackage.dimension = DimensionDto(value, null);
                        },
                      ),
                      InputStyle.offsetForm,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Dimension",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      TextFormField(
                        initialValue: "${widget.outboundPackage.pWidth.toString()}"
                            "x${widget.outboundPackage.pHeight.toString()}"
                            "x${widget.outboundPackage.pLength.toString()}",
                        validator: _dimensionValueValidate,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        onChanged: (value) {
                          List<double> result = _analDimension(value);
                          widget.outboundPackage.pWidth = result[0];
                          widget.outboundPackage.pHeight = result[1];
                          widget.outboundPackage.pLength = result[2];
                        },
                      ),
                      InputStyle.offsetForm,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Unit of Weight",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      DropdownButtonFormField<int>(
                        value: widget.outboundPackage.weight?.id,
                        hint: const Text("Select Weight Unit"),
                        decoration: InputStyle.inputTextForm,
                        items: state.weightUnit.entries.map((MapEntry<int, String> e) {
                          return DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value),
                          );
                        }).toList(),
                        validator: (value) => Utils.validateRequire(value.toString(), "Weight unit"),
                        onChanged: (value) {
                          widget.outboundPackage.weight = Weight(value, null);
                        },
                      ),
                      InputStyle.offsetForm,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Weight",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.black)
                              ),
                              TextSpan(text: " *",
                                  style: TextStyleMobile.h1_14.
                                  copyWith(color: Colors.red)
                              ),
                            ]
                        )),
                      ),
                      InputStyle.offsetText,
                      TextFormField(
                        initialValue: widget.outboundPackage.pWeight.toString(),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: InputStyle.inputTextForm,
                        validator: _weightValueValidate,
                        onChanged: (value) {
                          if(Utils.validateDoubleNumber(value)){
                            widget.outboundPackage.pWeight = double.parse(value);
                          }
                        },
                      ),
                      InputStyle.offsetForm,
                    ],
                  )
              )
                  : Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        if (value != null){
                          setState(() {
                            searchKey = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search SKU",
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.grey
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MobileColor.orangeColor,
                                  width: 2
                              )
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0)
                      ),
                    ),
                    InputStyle.offsetForm,
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: state.objectForm.outboundProductDetails!.map((e) {

                            bool check = e.sku!.contains(searchKey);
                            if(check){
                              OutboundPackageProductDetail oldPackage = _getOldPackage(e.product!);
                              double oldValue = oldPackage.packagedQty ?? 0;

                              double unfulfilled = e.pickedUnitQty! - (unfulfilledQty[e.product!.id] ?? 0);
                              mapResult[e.product!.id!] = oldPackage;
                              double factor = mapFactor[e.product!.id!] ?? 1;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 100,
                                decoration: BoxDecoration(
                                    color: oldValue > 0
                                        ? MobileColor.softOrangeColor
                                        : MobileColor.grayButtonColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: oldValue > 0 ? Border.all(
                                        color: MobileColor.orangeColor,
                                        width: 2
                                    ) : null
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: oldValue > 0 ? MobileColor.orangeColor : Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Image(image: oldValue > 0
                                            ? AssetsImage.whiteVectorImage
                                            : AssetsImage.blackVectorImage),
                                      ),
                                    ),
                                    Expanded(child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(e.product?.name ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyleMobile.h2_12,),
                                          Text("SKU: ${e.sku}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyleMobile.body_12,),
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: "Picked: ",
                                                      style: TextStyleMobile.body_12.copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                    TextSpan(text: e.pickedUnitQty.toString(),
                                                      style: TextStyleMobile.h2_12.copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: "Unfulfilled: ",
                                                      style: TextStyleMobile.body_12.copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                    TextSpan(text: unfulfilled.toString(),
                                                      style: TextStyleMobile.h2_12.copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      width: 70,
                                      height: 45,
                                      margin: const EdgeInsets.only(right: 10, top: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: TextFormField(
                                        initialValue: oldValue.toString(),
                                        maxLines: 1,
                                        textAlignVertical: TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        decoration: InputStyle.qtyTextForm,
                                        validator: (value) => _checkPackageQty(value, unfulfilled, oldValue),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                        ],
                                        onChanged: (value) {
                                          oldPackage.packagedUnitQty = double.parse(value) * factor;
                                          oldPackage.packagedQty = double.parse(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );}
                            return const SizedBox();
                              }).toList()
                        ),
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}


