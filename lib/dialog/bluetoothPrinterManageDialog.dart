import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_outbound/cascadeStyle/image.dart';
import 'package:flutter_outbound/state/bluetoothPrinter.dart';
import 'package:provider/provider.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';

class BluetoothPrinterManageDialog extends StatefulWidget {
  const BluetoothPrinterManageDialog({super.key});

  @override
  State<BluetoothPrinterManageDialog> createState() => _BluetoothPrinterManageDialogState();
}

class _BluetoothPrinterManageDialogState extends State<BluetoothPrinterManageDialog> {

  TextSpan _deviceStatus(BluetoothDevice device){
    switch (device.state) {
      case BluetoothDeviceState.connecting:
        return TextSpan(text: "Connecting...",
          style: TextStyleMobile.body_12.copyWith(color: Colors.blue),);
      case BluetoothDeviceState.connected:
        return TextSpan(text: "Connected",
          style: TextStyleMobile.body_12.copyWith(color: MobileColor.orangeColor),);
      case BluetoothDeviceState.disconnected:
        return TextSpan(text: "Disconnect",
          style: TextStyleMobile.body_12.copyWith(color: Colors.red),);
      default:
        return TextSpan(text: "Ready",
          style: TextStyleMobile.body_12.copyWith(color: Colors.green),);
    }
  }
  void _connectToDevice(BluetoothDevice device) {
    print("check");
    device.connect().then((_) {
      print('Kết nối thành công với thiết bị: ${device.name}');
    }).catchError((error) {
      print('Lỗi khi kết nối với thiết bị: $error');
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Provider.of<BluetoothPrinter>(context, listen: false).setupBluetoothStateListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothPrinter>(
      builder: (context, state, child) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
          insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
          titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          surfaceTintColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                child: Text("CHOOSE A PRINTER",
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
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              const Image(image: AssetsImage.printImage),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isBluetoothOn ? state.startScan : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state.isBluetoothOn
                          ? const Icon(Icons.bluetooth_connected_outlined,
                        color: MobileColor.greenButtonColor,)
                          : const Icon(Icons.bluetooth_disabled_outlined,
                        color: Colors.grey,),
                      const SizedBox(width: 10,),

                      state.isBluetoothOn
                          ? Text("Scan by bluetooth",
                        style: TextStyleMobile.button_14.copyWith(
                            color: MobileColor.greenButtonColor
                        ),
                      )
                          : Text("Bluetooth unavailable",
                        style: TextStyleMobile.button_14.copyWith(
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: SingleChildScrollView(
                    // child: Column(
                    //   children: [
                    //     TextButton(
                    //         onPressed: state.onGetIPInfo,
                    //         child: Text('onGetPrinterInfo')),
                    //     TextButton(
                    //         onPressed: state.onTestConnect,
                    //         child: Text('onTestConnect')),
                    //     TextButton(
                    //         onPressed: state.onTestTCP,
                    //         child: Text('Print TCP')),
                    //     TextButton(
                    //         onPressed: state.onTestBluetooth,
                    //         child: Text('Print Bluetooth')),
                    //   ],
                    // ),

                    child: Column(
                      children: state.scanResults.map((e) {
                        print(e);
                        return InkWell(
                          onTap: () {
                            _connectToDevice(e.device);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: MobileColor.grayButtonColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Icon(Icons.bluetooth, color: Colors.grey),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(e.device.name,
                                        style: TextStyleMobile.body_14.copyWith(
                                            color: Colors.black
                                        )
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Condition: ",
                                                  style: TextStyleMobile.body_12.copyWith(
                                                      color: Colors.grey
                                                  )
                                              ),
                                              _deviceStatus(e.device),
                                            ]
                                        )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
              ),
              const SizedBox(height: 15,)

            ],
          ),
        );
      },
    );

  }
}