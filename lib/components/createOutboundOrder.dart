import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/components/formOutbound.dart';
import 'package:flutter_outbound/components/stepperCustom.dart';

class CreateOutboundOrder extends StatelessWidget {
  const CreateOutboundOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            title: Text("OUTBOUND ORDER DETAIL",
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
          body: Container(
            color: MobileColor.grayButtonColor,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  height: 65,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                            ),
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.delete_forever_outlined, color: Colors.white, size: 20),
                                Text("Void", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                              ],
                            )
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MobileColor.greenButtonColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                            ),
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.save_outlined, color: Colors.white, size: 20),
                                Text("Save", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                              ],
                            )
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MobileColor.orangeColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                            ),
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.print_outlined, color: Colors.white, size: 20),
                                Text("Print", style: TextStyleMobile.button_14.copyWith(color: Colors.white)),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                const StepperCustom(),
                const SizedBox(height: 10,),
                const FormOutbound()
              ],
            ),
          )
      ),
    );
  }
}

