import 'package:flutter/material.dart';
import 'package:flutter_outbound/model/outboundPackedDto.dart';
import 'package:flutter_outbound/service/apiConnector.dart';
import 'package:flutter_outbound/service/stepRender.dart';
import 'package:flutter_outbound/service/util.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';
import '../model/outbound.dart';
import '../model/outboundPackage.dart';

class ReviewPackageDialog extends StatefulWidget {
  const ReviewPackageDialog({super.key, required this.outboundPackedDto});
  final OutboundPackedDto outboundPackedDto;

  @override
  State<ReviewPackageDialog> createState() => _AddProductToPackageState();
}

class _AddProductToPackageState extends State<ReviewPackageDialog> {
  int step = 0;
  OutboundPackage? outboundPackage;
  String searchKey = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getOutboundPackage();
  }

  Future<void> getOutboundPackage() async {
    Outbound? outbound = await ApiConnector.getOutboundById(widget.outboundPackedDto.outboundId!);
    Set<OutboundPackage> setPackage = outbound!.outboundPackages ?? {};
    for (var element in setPackage) {
      if(element.id == widget.outboundPackedDto.id) {
        outboundPackage = element;
        setState(() {
          isLoading = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox();
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("PRODUCTS TO PACKAGE",
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
              Navigator.of(context).pop();
            } else {
              setState(() {step = 1;});
            }
          },
          child: Text((step == 0) ? "Next" : "Close", style: TextStyleMobile.h1_14
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
                  child: step == 0 ?
                      Column(
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
                            initialValue: outboundPackage!.name,
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
                            initialValue: outboundPackage!.trackingNo,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputStyle.inputTextForm,
                            readOnly: true,
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
                          Row(
                            children: [
                              Utils.renderBoxDimension(
                                  Text(outboundPackage!.pLength.toString(),
                                    style: TextStyleMobile.button_14,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text("L",style: TextStyleMobile.button_14,),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("x"),
                              ),
                              Utils.renderBoxDimension(
                                Text(outboundPackage!.pWidth.toString(),
                                  style: TextStyleMobile.button_14,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text("W",style: TextStyleMobile.button_14,),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("x"),
                              ),
                              Utils.renderBoxDimension(
                                Text(outboundPackage!.pHeight.toString(),
                                  style: TextStyleMobile.button_14,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text("H",style: TextStyleMobile.button_14,),
                              ),
                            ],
                          ),
                          InputStyle.offsetText,
                          TextFormField(
                            initialValue: outboundPackage!.dimension!.dimensionUnit,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputStyle.inputTextForm,
                            readOnly: true,
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: outboundPackage!.pWeight.toString(),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputStyle.inputTextForm,
                                  readOnly: true,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  initialValue: outboundPackage!.weight!.weightUnit,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputStyle.inputTextForm,
                                  readOnly: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ) : Column(
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
                        SingleChildScrollView(
                          child: Column(
                            children: outboundPackage?.outboundPackageProductDetails?.map((e) {
                              bool check = e.sku!.contains(searchKey);
                              if(check){
                                return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: MobileColor.softOrangeColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: MobileColor.orangeColor,
                                            width: 2
                                        )
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
                                                color: MobileColor.orangeColor,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Image.asset('assets/images/Vectorwhite.png'),
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
                                              Row(
                                                children: [
                                                  Text("Packed QTY: ",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyleMobile.body_12,),
                                                  Expanded(
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(e.packagedQty.toString(),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyleMobile.h2_12,),
                                                      )
                                                  ),
                                                  const SizedBox(width: 10,)
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ));
                              } else {
                                return const SizedBox();
                              }
                            }).toList()
                                ?? [const SizedBox()]
                          ),
                        ),
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


