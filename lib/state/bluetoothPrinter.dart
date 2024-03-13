import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_zebra_sdk/flutter_zebra_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPrinter extends ChangeNotifier{
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  bool isBluetoothOn = false;

  void startScan() {
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      scanResults = results.where((result) => result.device.name.isNotEmpty).toList();
      notifyListeners();
    }).onDone(() {
      flutterBlue.stopScan();
    });
  }
  void setupBluetoothStateListener() {
    flutterBlue.state.listen((BluetoothState state) {
      switch (state) {
        case BluetoothState.on:
          isBluetoothOn = true;
          startScan();
          break;
        case BluetoothState.off:
          isBluetoothOn = false;
          scanResults = [];
          break;
        default:
          print("Error bluetooth");
          isBluetoothOn = false;
          scanResults = [];
          break;
      }
      notifyListeners();
    });
  }



  Future<void> onGetIPInfo() async {
    var a = await ZebraSdk.onGetPrinterInfo('127.0.0.37', port: 9100);
    print(a);
  }

  Future<void> onTestConnect() async {
    var a = await ZebraSdk.isPrinterConnected('127.0.0.37', port: 9100);
    print(a);
    var b = json.decode(a);
    print(b);
  }

  Future<void> onTestTCP() async {
    String data = "^XA^FO100,100^A0N56,66^FDTHANGQUOC PRINTER TEST^FS^XZ";

    final rep = ZebraSdk.printZPLOverTCPIP('127.0.0.37', data: data);
    print(rep);
  }

  Future<void> onTestBluetooth() async {
    String data;
    data = "^XA^FO100,100^A0N56,66^FDTHANGQUOC PRINTER TEST^FS^XZ";

    String arr = '50:8C:B1:8D:10:C7';
    if (Platform.isIOS) {
      arr = '50J171201608';
    }
    final rep = ZebraSdk.printZPLOverBluetooth(arr, data: data);
    print(rep);
  }


}