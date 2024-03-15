import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/printBarcodeDialog.dart';
import 'package:flutter_outbound/model/relabelDetail.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../service/util.dart';

class SelectRelabelScannedDialog extends StatelessWidget {
  const SelectRelabelScannedDialog({super.key, required this.list});
  final List<RelabelDetail> list;


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      surfaceTintColor: Colors.white,
      title: Text("Select Relabel",
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
      content: SingleChildScrollView(
        child: Column(
          children: list.map((e) {
            return Container(
              height: 75,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                color: MobileColor.grayButtonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PrintBarcodeDialog(relabel: e,);
                      }
                  );
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.document_scanner_outlined,
                        color: MobileColor.orangeColor,
                        size: 28,
                      ),
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Original Barcode: ",
                                        style: TextStyleMobile.body_12.copyWith(
                                            color: Colors.black
                                        ),
                                      ),
                                      TextSpan(
                                        text: e.originalBarcode ?? "",
                                        style: TextStyleMobile.h2_12.copyWith(
                                            color: MobileColor.orangeColor
                                        ),
                                      )
                                    ]
                                )
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "New Barcode: ",
                                      style: TextStyleMobile.body_12.copyWith(
                                          color: Colors.black
                                      ),
                                    ),
                                    TextSpan(
                                      text: e.newBarcode ?? "",
                                      style: TextStyleMobile.h2_12.copyWith(
                                          color: MobileColor.orangeColor
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(Utils.convertFullTime(e.createdDate),
                                  style: TextStyleMobile.body_12.copyWith(
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
