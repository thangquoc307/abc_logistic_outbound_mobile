import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/addProductToPackageDialog.dart';
import 'package:flutter_outbound/model/outbound.dart';
import 'package:flutter_outbound/model/outboundPackage.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import '../../cascadeStyle/color.dart';
import '../../cascadeStyle/fonts.dart';
import '../../model/globalState.dart';
import '../../model/outboundProductDetails.dart';
import '../../service/apiConnector.dart';

class Step03 extends StatefulWidget {
  const Step03({super.key});

  @override
  State<Step03> createState() => _Step03State();
}

class _Step03State extends State<Step03> {
  static bool _packingMode = true;


  @override
  void initState() {
    super.initState();
    _packingMode = true;
  }
  String genePackageName(Outbound outbound) {
    Set<OutboundPackage>? setOutboundPackage = outbound.outboundPackages;
    if (setOutboundPackage != null){
      String prefix = "PKG-${outbound.customerProjectNo}-";
      int number = 1;

      while (number <= setOutboundPackage.length + 1) {
        String name = prefix + number.toString();
        if (!checkNameExist(setOutboundPackage, name)) {
          return name;
        } else {
          number++;
        }
      }
      return "";
    } else {
      return "";
    }
  }

  bool checkNameExist(Set<OutboundPackage> set, String name) {
    for (var element in set) {
      if (element.name == name) {
        return true;
      }
    }
    return false;
  }

  bool checkAllProductPacked(Map<int, double> mapProductPacked, Set<OutboundProductDetail> setProduct) {
    for (var element in setProduct) {
      double qty = mapProductPacked[element.product?.id] ?? 0;
      num picked = element.pickedUnitQty ?? 0;
      if (qty < picked) {
        return false;
      }
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context, listen: true);
    Map<int, double> unfulfilledQty = state.getUnfulfilledQty();

    return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(child: InkWell(
                    onTap: () {
                      setState(() {
                        _packingMode = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _packingMode ? Colors.white : null,
                          borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(12))
                      ),
                      child: Text("Packing", style: TextStyleMobile.body_14.copyWith(
                          color: _packingMode ? MobileColor.orangeColor : Colors.grey
                      )),
                    ),
                  )),
                  Expanded(child: InkWell(
                    onTap: () {
                      setState(() {
                        _packingMode = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: !_packingMode ? Colors.white : null,
                          borderRadius: const BorderRadiusDirectional.only(topStart: Radius.circular(12))
                      ),
                      child: Text("Remaining prod", style: TextStyleMobile.body_14.copyWith(
                          color: !_packingMode ? MobileColor.orangeColor : Colors.grey
                      )),
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white,
                    child: _packingMode
                        ? Column(
                          children: [
                            const SizedBox(height: 15,),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddProductToPackageDialog(
                                        outboundPackage: OutboundPackage.nullObject(
                                            genePackageName(state.objectForm)
                                        ),
                                        outboundProductDetail: state.objectForm.outboundProductDetails!,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    border: DashedBorder.fromBorderSide(
                                        dashLength: 5,
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 1)
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                    )
                                ),
                                child: const Icon(Icons.add, color: Colors.grey,)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SingleChildScrollView(
                              child: Column(
                                children: state.objectForm.outboundPackages!.map((e) {
                                  return Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    width: double.infinity,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MobileColor.softOrangeColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: MobileColor.orangeColor,
                                          width: 2
                                        )
                                      ),
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 15,),
                                          Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AddProductToPackageDialog(
                                                        outboundPackage: e,
                                                        outboundProductDetail: state.objectForm.outboundProductDetails!,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(e.name!,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyleMobile.button_14,
                                                ),
                                              )
                                          ),
                                          const Icon(Icons.print_outlined, color: MobileColor.orangeColor,),
                                          const SizedBox(width: 15,)
                                        ],
                                      ),
                                    ),

                                  );
                                }).toList(),
                              )
                            ),
                          ],
                        ) : SingleChildScrollView(
                    child: Column(
                      children: state.objectForm.outboundProductDetails!.map((e) {
                        double unfulQty = unfulfilledQty[e.product?.id] ?? 0;
                        return
                          Container(
                            width: double.infinity,
                            height: 80,
                            margin: const EdgeInsetsDirectional.only(top: 10),
                            decoration: BoxDecoration(
                                color: MobileColor.grayButtonColor,
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
                                        color: Colors.white,
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
                                                TextSpan(text: "Unfulfilled QTY: ",
                                                  style: TextStyleMobile.body_12.copyWith(
                                                      color: Colors.black
                                                  ),
                                                ),
                                                TextSpan(text: (e.pickedUnitQty! - unfulQty).toString(),
                                                  style: TextStyleMobile.h2_12.copyWith(
                                                      color: (e.pickedUnitQty! - unfulQty == 0)
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
                              ],
                            ),
                          );}
                      ).toList(),
                    )
                ),
              ),

            ),
            Container(
              color: Colors.white,
              child: Container(
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
                    color: Colors.white,
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
                              bool checkProduct = checkAllProductPacked(unfulfilledQty, state.objectForm.outboundProductDetails!);
                              if (checkProduct) {
                                ApiConnector.createOutbound(
                                    state.objectForm, false, context
                                );
                                Utils.showSnackBar(context, "Data is saved");
                                if (state.finishStep == 2){
                                  state.finishStep = state.finishStep + 2;
                                }
                                state.currentStep = 3;
                              } else {
                                Utils.showSnackBarAlert(context, "Please packing all Product");
                              }
                            },
                            child: Text("Ready to ship",
                                style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            )
          ],
        )
    );
  }
}
