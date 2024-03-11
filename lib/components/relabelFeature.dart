import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/bluetoothPrinterManageDialog.dart';
import 'package:flutter_outbound/dialog/printBarcodeDialog.dart';
import 'package:flutter_outbound/service/fakeData.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/relabel.dart';

class RelabelFeature extends StatefulWidget {
  const RelabelFeature({super.key});

  @override
  State<RelabelFeature> createState() => _RelabelFeatureState();
}

class _RelabelFeatureState extends State<RelabelFeature> {
  List<Relabel> relabelList = FakeData.zplCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MobileColor.grayButtonColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          title: Text("RELABEL FEATURE",
              style: TextStyleMobile.h1_14.copyWith(
                  color: MobileColor.orangeColor)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 5,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
              height: 65,
              child: TextField(
                onChanged: (value) {
                  if (value != null){
                    setState(() {

                    });
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Barcode",
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
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MobileColor.blueButtonColor
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const BluetoothPrinterManageDialog();
                    },
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Brother HL-L23600",
                              style: TextStyleMobile.button_14.copyWith(
                                color: Colors.white
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                          ),
                          RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Condition: ",
                                    style: TextStyleMobile.body_12.copyWith(
                                      color: Colors.white
                                    )
                                  ),
                                  TextSpan(
                                    text: "Ready",
                                    style: TextStyleMobile.h2_12.copyWith(
                                      color: Colors.white
                                    )
                                  ),
                                ]
                              ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.cached, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: relabelList.map((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: MobileColor.grayButtonColor,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Icon(Icons.document_scanner_outlined,
                                        color: Colors.grey,
                                        size: 28,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Original Barcode:",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyleMobile.button_14.copyWith(
                                                color: Colors.grey
                                              ),
                                            ),
                                            Text(e.originalBarcode,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyleMobile.h1_14.copyWith(
                                                color: Colors.black
                                              ),
                                            )
                                          ],
                                        )
                                    )

                                  ],
                                ),
                              ),
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.print_outlined,
                                size: 28,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PrintBarcodeDialog(relabel: e,);
                                  }
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
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
              child: Container(
                decoration: BoxDecoration(
                    color: MobileColor.orangeColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: TextButton(
                    onPressed: () {

                    },
                    child: Text("Scanned", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
