import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/pickedQtyDialog.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:flutter_outbound/model/outboundProductDetails.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

import '../../cascadeStyle/color.dart';
import '../../cascadeStyle/fonts.dart';
import '../../model/outboundLocationProductDetails.dart';
import '../../service/apiConnector.dart';

class Step02 extends StatelessWidget {
  const Step02({super.key});

  num _sumQty(List<OutboundLocationProductDetails> list) {
    num result = 0;
    for (var element in list) {
      result += element.pickedUnitQty!;
    }
    return result;
  }

  bool _checkQty(Set<OutboundProductDetail> set){
    if (set.isEmpty || set == null) {
      return false;
    }
    for (var element in set) {
      if (element.pickedUnitQty != _sumQty(element.outboundLocationProductDetails!)){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GlobalState>(context, listen: true);

    return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 65,
                child: TextField(
                  onChanged: (value) {
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search UPC",
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
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: state.objectForm.outboundProductDetails!.map((e) {
                    num qtyPick = _sumQty(e.outboundLocationProductDetails!);
                    return
                      Container(
                        width: double.infinity,
                        height: 80,
                        margin: const EdgeInsetsDirectional.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
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
                                    color: MobileColor.grayButtonColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Image.asset('assets/images/Vector.png'),
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
                                            TextSpan(text: "Unit QTY: ",
                                              style: TextStyleMobile.body_12.copyWith(
                                                  color: Colors.black
                                              ),
                                            ),
                                            TextSpan(text: qtyPick.toString(),
                                              style: TextStyleMobile.h2_12.copyWith(
                                                  color: qtyPick == e.pickedUnitQty
                                                      ? MobileColor.greenButtonColor
                                                      : Colors.red
                                              ),
                                            ),
                                            TextSpan(text: " / ${e.pickedUnitQty.toString()}",
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
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PickedQtyDialog(outboundProductDetail: e,);
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.topCenter,
                                width: 30,
                                padding: const EdgeInsets.only(right: 10, top: 10),
                                child: const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                              ),
                            )
                          ],
                        ),
                      );}
                  ).toList(),
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 30),
              height: 90,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10
                    )
                  ],
                  borderRadius: const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(24),
                      topStart: Radius.circular(24)
                  ),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MobileColor.orangeColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: TextButton(
                          onPressed: () {
                            bool checkQty = _checkQty(state.objectForm.outboundProductDetails!);
                            if (checkQty) {
                              ApiConnector.createOutbound(
                                  state.objectForm, false
                              );
                              Utils.showSnackBar(context, "Data is saved");
                              if (state.finishStep == 1){
                                state.finishStep++;
                              }
                              state.currentStep = 2;
                            } else {
                              Utils.showSnackBarAlert(context, "Please select sufficient quantity");
                            }
                          },
                          child: Text("Complete Picked",
                              style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            )
        ]
      ),
    );
  }
}
