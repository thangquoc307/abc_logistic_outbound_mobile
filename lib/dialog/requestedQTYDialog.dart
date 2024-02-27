import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
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
              state.editRequestedQty(widget.editedElement.id,
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prob Name:  ", style: TextStyleMobile.body_14.copyWith(color: Colors.grey)),
                    InputStyle.offsetText,
                    Text("SKU:  ", style: TextStyleMobile.body_14.copyWith(color: Colors.grey)),
                    InputStyle.offsetText,
                    Text("UPC:  ", style: TextStyleMobile.body_14.copyWith(color: Colors.grey)),
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputStyle.inputTextForm,
                        onChanged: (value) {
                          setState(() {
                            _unitQtyController.text = (double.parse(value) * _factor!).toString();
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
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
