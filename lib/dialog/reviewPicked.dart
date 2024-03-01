import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/cascadeStyle/input.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/inventoryLocationProductDetail.dart';
import '../model/outbound.dart';
import '../model/outboundProductDetailDto.dart';
import '../service/apiConnector.dart';

class ReviewPickedDialog extends StatefulWidget {
  const ReviewPickedDialog({super.key, required this.outboundProductDetailDto});
  final OutboundProductDetailDto outboundProductDetailDto;
  @override
  State<ReviewPickedDialog> createState() => _ReviewPickedDialogState();
}

class _ReviewPickedDialogState extends State<ReviewPickedDialog> {
  OutboundProductDetail? outboundProductDetail;
  String searchKey = "";
  bool outboundLoading = false;
  bool inventoryLoading = false;
  double numberOfProduct = 0;
  List<InventoryLocationProductDetail>? inventoryList;

  @override
  void initState() {
    super.initState();
    getOutboundPicked();
    getInventory();
  }

  Future<void> getInventory() async {
    var res = await ApiConnector.getInventoryLocationProductDetail(widget.outboundProductDetailDto.productId);
    if (res != null){
      inventoryList = res;
    }
    setState(() {
      inventoryLoading = true;
    });
  }
  Future<void> getOutboundPicked() async {
    Outbound? outbound = await ApiConnector.getOutboundById(widget.outboundProductDetailDto.outboundId!);
    Set<OutboundProductDetail> setProductDetail = outbound!.outboundProductDetails ?? {};
    for (var element in setProductDetail) {
      if(element.id == widget.outboundProductDetailDto.id) {
        outboundProductDetail = element;
        for (var count in element.outboundLocationProductDetails!){
          if (count != null) {
            numberOfProduct += count.pickedUnitQty ?? 0;
          }
        }
        setState(() {
          outboundLoading = true;
        });
        break;
      }
    }
  }

  num getOnHandQty(int locationId){
    if (inventoryList != null){
      for(var element in inventoryList!) {
        if(element.locationId == locationId){
          return element.totalUnitQty ?? 0;
        }
      }
    } else {
      return 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (!outboundLoading || !inventoryLoading) {
      return const SizedBox();
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("LOCATION - SKU ${widget.outboundProductDetailDto.sku}",
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
      ],
      content: Column(
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
                                child: Text(numberOfProduct.toString(),
                                          style: TextStyleMobile.body_14.copyWith(
                                              color: numberOfProduct == outboundProductDetail!.requestedUnitQty
                                                  ? MobileColor.greenButtonColor
                                                  : Colors.black
                                          )
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
                                child: Text(outboundProductDetail!.requestedUnitQty.toString(),
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
                    SingleChildScrollView(
                      child: Column(
                        children: outboundProductDetail?.outboundLocationProductDetails?.map((e) {
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
                                      e.location?.locationNo ?? "",
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
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Picked Unit QTY",
                                            style: TextStyleMobile.body_12,
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
                                          child: Text(getOnHandQty(e.location!.id!).toString(),
                                              style: TextStyleMobile.body_14
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                            initialValue: e.pickedUnitQty.toString(),
                                            decoration: InputStyle.inputTextForm,
                                            style: TextStyleMobile.body_14,
                                            textAlign: TextAlign.center,
                                            readOnly: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList() ?? [const SizedBox()],
                      ),
                    ),
                  ],
                )
    );
  }
}
