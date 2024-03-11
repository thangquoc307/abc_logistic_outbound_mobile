import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';

class BluetoothPrinterManageDialog extends StatefulWidget {
  const BluetoothPrinterManageDialog({super.key});

  @override
  State<BluetoothPrinterManageDialog> createState() => _BluetoothPrinterManageDialogState();
}

class _BluetoothPrinterManageDialogState extends State<BluetoothPrinterManageDialog> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }
  Future<void> _checkBluetoothState() async {
    bool bluetoothState = await flutterBlue.isOn;
    setState(() {
      isBluetoothOn = bluetoothState;
    });
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
      title: Text("CHOOSE A PRINTER",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      content: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ],
      ),
    );
  }
}