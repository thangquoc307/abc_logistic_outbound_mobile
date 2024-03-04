import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/cascadeStyle/input.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/inventoryLocationProductDetail.dart';
import '../model/outboundLocationProductDetails.dart';
import '../service/apiConnector.dart';

class PickedQtyDialog extends StatefulWidget {
  const PickedQtyDialog({super.key, required this.outboundProductDetail});
  final OutboundProductDetail outboundProductDetail;
  @override
  State<PickedQtyDialog> createState() => _PickedQtyDialogState();
}

class _PickedQtyDialogState extends State<PickedQtyDialog> {
  late Future<List<InventoryLocationProductDetail>?> _futureProductDetails;
  Map<int, TextEditingController> listController = {};
  ValueNotifier<int> numberOfProductNotifier = ValueNotifier<int>(0);

  void calNumberOfProduct() {
    int result = 0;
    for (var element in listController.values) {
      result += int.parse(element.text) ?? 0;
    }
    numberOfProductNotifier.value = result;
  }
  bool _checkEqualTotal() {
    return numberOfProductNotifier.value == widget.outboundProductDetail.requestedUnitQty!;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? checkQtyOnHand(String? value, int maxQty, num oldValue){
    if (value == null || value.isEmpty) {
      return "require";
    }
    int qty = int.parse(value);
    num dif = qty - oldValue;
    if (dif > maxQty) {
      return "max ${oldValue + maxQty}";
    }
  }

  num getOldValue(InventoryLocationProductDetail inventory) {
    List<OutboundLocationProductDetails>? list = widget.outboundProductDetail.outboundLocationProductDetails;

    for(int i = 0; i < list!.length; i++){
      OutboundLocationProductDetails item = list[i];
      if(item.location!.id == inventory.locationId){
        return item.pickedUnitQty!;
      }
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    _futureProductDetails = ApiConnector.getInventoryLocationProductDetail(widget.outboundProductDetail.product?.id);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("LOCATION - SKU ${widget.outboundProductDetail.sku}",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if (!_checkEqualTotal()) {
              Utils.showSnackBarAlert(context, "Number of Product not equal request");
            } else if (_formKey.currentState!.validate()){
              var state = Provider.of<GlobalState>(context, listen: false);
              state.updateQtyPicked(widget.outboundProductDetail, listController, context);
              Navigator.of(context).pop();
            }
          },
          child: Text("Save", style: TextStyleMobile.h1_14
              .copyWith(color: MobileColor.orangeColor)),
        ),
      ],
      content: FutureBuilder<List<InventoryLocationProductDetail>?>(
        future: _futureProductDetails,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == null) {
                return const Text('No data available');
              } else {
                return Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "Number of products",
                                    style: TextStyleMobile.body_14.
                                    copyWith(color: Colors.black)
                                ),
                                TextSpan(text: " *",
                                    style: TextStyleMobile.body_14.
                                    copyWith(color: Colors.red)
                                ),
                              ]
                          )),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                color: MobileColor.grayButtonColor,
                                child: ValueListenableBuilder(
                                  valueListenable: numberOfProductNotifier,
                                  builder: (context, value, child) {
                                    return
                                      Text(numberOfProductNotifier.value.toString(),
                                          style: TextStyleMobile.body_14.copyWith(
                                              color: _checkEqualTotal()
                                                  ? MobileColor.greenButtonColor
                                                  : Colors.red
                                          )
                                      );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                                child: Icon(Icons.lock_outline, color: Colors.grey, size: 20)
                            ),
                            Expanded(
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                color: MobileColor.grayButtonColor,
                                child: Text(widget.outboundProductDetail.requestedUnitQty.toString(),
                                  style: TextStyleMobile.body_14.copyWith(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Location", style: TextStyleMobile.body_14.copyWith(color: Colors.grey)),
                        const Expanded(child: SizedBox()),
                        Text("Unit QTY", style: TextStyleMobile.body_14.copyWith(color: Colors.grey)),
                      ],
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.map((e) {
                            num oldValue = getOldValue(e);
                            TextEditingController controller = TextEditingController(
                              text: oldValue.toString()
                            );
                            listController[e.locationId!] = controller;
                            calNumberOfProduct();

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 60,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 45,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: MobileColor.orangeColor,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                          e.locationNo!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyleMobile.button_14.copyWith(
                                              color: Colors.white
                                          ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5,),
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "On Hand Unit QTY",
                                                style: TextStyleMobile.body_12,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "Picked Unit QTY",
                                              style: TextStyleMobile.body_12,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 30,),
                                  SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(e.totalUnitQty.toString(),
                                                  style: TextStyleMobile.body_14
                                              ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                calNumberOfProduct();
                                              },
                                              controller: controller,
                                              validator: (value) => checkQtyOnHand(value, e.totalUnitQty!, oldValue),
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                              ],
                                              decoration: InputStyle.inputTextForm,
                                              style: TextStyleMobile.body_14,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          }
        },
      ),
    );
  }
}
