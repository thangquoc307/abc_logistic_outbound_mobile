
import 'package:flutter/material.dart';
import 'package:flutter_zebra_sdk/flutter_zebra_sdk.dart';

class TestPrinter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZPL Printer Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ZPL Printer Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _printToNetworkPrinter();
                },
                child: Text('Print to Network Printer'),
              ),
              ElevatedButton(
                onPressed: () {
                  _printToBluetoothPrinter();
                },
                child: Text('Print to Bluetooth Printer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _printToNetworkPrinter() async {
    try {
      await ZebraSdk.printZPLOverTCPIP('127.0.0.37',
        port: 9100,
        data: '^XA^FO100,100^ADN,36,20^FDHello, World!^FS^XZ',
      );
    } catch (e) {
      print('Error printing: $e');
    }
  }

  Future<void> _printToBluetoothPrinter() async {
    try {
      String deviceAddress = '00:11:22:33:AA:BB';
      await ZebraSdk.printZPLOverBluetooth(deviceAddress,
        data: '^XA^FO100,100^ADN,36,20^FDHello, World!^FS^XZ',
      );
    } catch (e) {
      print('Error printing: $e');
    }
  }
}