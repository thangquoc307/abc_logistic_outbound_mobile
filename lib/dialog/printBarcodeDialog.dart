import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_outbound/model/relabel.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../service/apiConnector.dart';

class PrintBarcodeDialog extends StatefulWidget {
  const PrintBarcodeDialog({super.key, required this.relabel, });
  final Relabel relabel;
  @override
  State<PrintBarcodeDialog> createState() => _PrintBarcodeDialogState();
}

class _PrintBarcodeDialogState extends State<PrintBarcodeDialog> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    getImageFromAPI();
  }

  Future<void> getImageFromAPI() async {
    Uint8List? bitCode = await ApiConnector.convertZplToImage(widget.relabel.zplCode);
    setState(() {
      imageData = bitCode;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: AlertDialog(
        contentPadding: const EdgeInsets.only(right: 24, left: 24, top: 12,),
        insetPadding: const EdgeInsets.symmetric(vertical: 24.0),
        titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: Text("RELABEL",
                  style: TextStyleMobile.h1_14
                      .copyWith(
                      color: MobileColor.orangeColor
                  )
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close,
                  color: Colors.grey,
                size: 25,
              ),
            )
          ],
        ),

        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Original Barcode",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleMobile.body_14.copyWith(
                color: Colors.grey
              ),
            ),
            Text(widget.relabel.originalBarcode,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleMobile.h1_14.copyWith(
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 10,),
            Text("New Barcode",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleMobile.body_14.copyWith(
                  color: Colors.grey
              ),
            ),
            Text(widget.relabel.newBarcode,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleMobile.h1_14.copyWith(
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  )
                ),
                  child: imageData != null
                      ? Image.memory(imageData!,
                    fit: BoxFit.contain,
                  ) : const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 15,),
            InkWell(
              onTap: () {
                ApiConnector.printZpl(widget.relabel.zplCode);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: MobileColor.orangeColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Print Label", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}
