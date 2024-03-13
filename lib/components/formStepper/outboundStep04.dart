import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/addReceiverDialog.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/model/shippingAddress.dart';
import 'package:flutter_outbound/model/shippingPackage.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:provider/provider.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../../cascadeStyle/color.dart';
import '../../cascadeStyle/fonts.dart';
import '../../cascadeStyle/image.dart';
import '../../state/globalState.dart';

class Step04 extends StatefulWidget {
  const Step04({super.key});

  @override
  State<Step04> createState() => _Step04State();
}

class _Step04State extends State<Step04> {
  double countTotalPack(Shipping shipping) {
    double count = 0;
    Set<ShippingPackage> setShipping = shipping.shippingPackages!;
    for (var element in setShipping) {
      Set<OutboundPackageProductDetail> packageProductDetail = element.outboundPackage!.outboundPackageProductDetails!;
      for (var pack in packageProductDetail) { 
        count += pack.packagedQty ?? 0;
      }
    }
    return count;
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context, listen: true);

    return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddReceiverDialog(
                                shipping: Shipping(
                                    null, DateTime.now(), DateTime.now(),
                                    null, null, null, null, null, null,
                                    null, null, null, null, null, null,
                                    null, null, null, null,
                                    DateTime.now(), {},
                                    ShippingAddress(null, null, null, null, null, null, null),
                                    ShippingAddress(null, null, null, null, null, null, null)
                                ),
                              setPackaged: state.objectForm.outboundPackages ?? {},
                              dataSubmit: (Shipping shipping) {
                                state.objectForm.shippings?.add(shipping);
                                state.createOutbound(false);

                              },
                            );
                          },
                        );
                      },
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
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
                    const SizedBox(height: 15,),
                    SingleChildScrollView(
                        child: Column(
                          children: state.objectForm.shippings!.map((e) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddReceiverDialog(
                                        shipping: Shipping.fromJson(e.toJson()),
                                      setPackaged: state.objectForm.outboundPackages ?? {},
                                      dataSubmit: (Shipping shipping) {
                                          state.objectForm.shippings?.remove(e);
                                          state.objectForm.shippings?.add(shipping);
                                          state.createOutbound(false);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                height: 75,
                                child: Row(
                                    children: [
                                      const Image(image: AssetsImage.shippingImage),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(e.sender ?? "",
                                              style: TextStyleMobile.h1_14,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text("Pack Total: ${countTotalPack(e)}",
                                              style: TextStyleMobile.body_14.copyWith(
                                                color: Colors.grey
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      )
                                    ]
                                ),
                              ),
                            );
                          }).toList(),
                        )
                    ),
                  ],
                )
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
                              state.currentStep++;
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
