import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';

class RequestedQTYDialog extends StatefulWidget {
  final OutboundProductDetail editedElement;
  const RequestedQTYDialog({super.key, required this.editedElement});

  @override
  State<RequestedQTYDialog> createState() => _RequestedQTYDialogState();
}

class _RequestedQTYDialogState extends State<RequestedQTYDialog> {
  final TextEditingController _mcQtyController = TextEditingController();
  final TextEditingController _unitQtyController = TextEditingController();

  num? _maxQty;
  num? _oldQty;
  double? _factor;

  @override
  void initState() {
    super.initState();
    _oldQty = widget.editedElement.requestedQty;

    _mcQtyController.text = _oldQty.toString();
    _unitQtyController.text = widget.editedElement.requestedUnitQty.toString();
    
    if (_maxQty == null) {
      _initializeQty();
    }
  }
  void _initializeQty() async {
    double? valueMaxQty = await ApiConnector.getQtyRemainingInInventory(widget.editedElement.id, 0);
    double? valueFactor = await ApiConnector.getConvertFactor(widget.editedElement.product!.id!);
    _maxQty = valueMaxQty;
    _factor = valueFactor;
  }


  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GlobalState>(context);

    String requestedQtyValidation() {
      String value = _mcQtyController.text;
      if (value == null || value.isEmpty) {
        return "Please enter a quantity";
      }
      double qty = double.parse(value!);
      if (qty <= 0){
        return "Quantity not equal 0";
      } else if (_maxQty != null && qty - _oldQty! > _maxQty!) {
        return "Quantity max is ${_maxQty! + _oldQty!}";
      } else {
        return "";
      }
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("PRODUCT INFORMATION",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      actions: [
        TextButton(
          onPressed: () {
            state.delRequestProduct(widget.editedElement.product!);
            Navigator.of(context).pop();
          },
          child: Text("Delete", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if (requestedQtyValidation() == "") {
              state.editRequestedQty(widget.editedElement.product!.id,
                  double.parse(_mcQtyController.text),
                  double.parse(_unitQtyController.text)
              );
              Navigator.of(context).pop();
            }
          },
          child: Text("Save", style: TextStyleMobile.h1_14
              .copyWith(color: MobileColor.orangeColor)),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.8),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prob Name:  ",
                        style: TextStyleMobile.body_14.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    InputStyle.offsetText,
                    Text("SKU:  ",
                        style: TextStyleMobile.body_14.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    InputStyle.offsetText,
                    Text("UPC:  ",
                        style: TextStyleMobile.body_14.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.editedElement.product?.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleMobile.body_14.copyWith(color: Colors.black)),
                      InputStyle.offsetText,
                      Text(widget.editedElement.sku ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleMobile.body_14.copyWith(color: Colors.black)),
                      InputStyle.offsetText,
                      Text(widget.editedElement.product?.upc ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyleMobile.body_14.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
            InputStyle.offsetForm,

            Align(
              alignment: Alignment.centerLeft,
                child: Text("Change Unit:",
                    style: TextStyleMobile.body_14.copyWith(color: Colors.grey)
                )
            ),
            InputStyle.offsetText,
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("MC QTY",
                        textAlign: TextAlign.center,
                        style: TextStyleMobile.body_14.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      // height: 50,
                      width: 50,
                    ),
                    Expanded(
                      child: Text("Unit QTY",
                        textAlign: TextAlign.center,
                        style: TextStyleMobile.body_14.copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mcQtyController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        onChanged: (value) {
                          setState(() {
                            if (Utils.validateDoubleNumber(value)){
                              _unitQtyController.text = (double.parse(value) * _factor!).toString();
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.cached, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _unitQtyController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        onChanged: (value) {
                          setState(() {
                            _mcQtyController.text = (double.parse(value) / _factor!).toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Text(requestedQtyValidation(),
                    style: TextStyleMobile.button_14.copyWith(
                    color: Colors.red
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
