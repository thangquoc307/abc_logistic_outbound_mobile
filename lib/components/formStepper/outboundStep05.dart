import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/dialog/reviewShipping.dart';
import 'package:flutter_outbound/model/outboundPackageProductDetail.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/model/shippingPackage.dart';
import 'package:provider/provider.dart';
import '../../cascadeStyle/fonts.dart';
import '../../model/globalState.dart';

class Step05 extends StatefulWidget {
  const Step05({super.key});

  @override
  State<Step05> createState() => _Step05State();
}

class _Step05State extends State<Step05> {
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
                      SingleChildScrollView(
                          child: Column(
                            children: state.objectForm.shippings!.map((e) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ReviewShipping(
                                        shipping: e,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  height: 75,
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/shipItem.png"),
                                      const SizedBox(width: 10,),
                                      Column(
                                        children: [
                                          Expanded(
                                            child: Text(e.sender ?? "",
                                              style: TextStyleMobile.h1_14.copyWith(color: MobileColor.orangeColor),
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
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
