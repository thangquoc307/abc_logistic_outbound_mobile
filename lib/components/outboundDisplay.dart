import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/components/orderList.dart';
import 'package:flutter_outbound/components/packedList.dart';
import 'package:flutter_outbound/components/pickedList.dart';
import 'package:flutter_outbound/components/shipList.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:provider/provider.dart';

class OutboundDisplay extends StatefulWidget {
  const OutboundDisplay({super.key});

  @override
  State<OutboundDisplay> createState() => _OutboundDisplayState();
}

class _OutboundDisplayState extends State<OutboundDisplay> {
  int _step = 0;

  Color _checkStep(int stepNumber){
    if (_step == stepNumber){
      return MobileColor.orangeColor;
    } else {
      return Colors.grey;
    }
  }
  Widget renderView() {
    switch (_step) {
      case 0:
        return const OrderOutboundList();
      case 1:
        return const PickedList();
      case 2:
        return const PackedList();
      case 3:
        return const OutboundShippedList();
      default:
        return const Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            title: Text("OUTBOUND ORDER INFORMATION",
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Column(
                  children: [
                    Consumer<GlobalState>(
                        builder: (context, state, child) {
                          return
                            ElevatedButton(
                                onPressed: () {
                                  state.setupFormCreate();
                                  Navigator.pushNamed(context, "/create");
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  backgroundColor: MobileColor.blueButtonColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add, color: Colors.white),
                                    const SizedBox(width: 10,),
                                    Text("Add Outbound Order",
                                        style: TextStyleMobile.button_14.copyWith(
                                            color: Colors.white
                                        )),
                                  ],
                                )
                            );
                        },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _step = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                          Icons.view_list,
                                        color: _checkStep(0),
                                      ),
                                      const SizedBox(height: 3,),
                                      Text("Order", style: TextStyleMobile.button_14.copyWith(
                                        color: _checkStep(0)
                                      )),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(width: 7,),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _step = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.shelves,
                                        size: 25,
                                        color: _checkStep(1),
                                      ),
                                      const SizedBox(height: 3,),
                                      Text("Pick", style: TextStyleMobile.button_14.copyWith(
                                          color: _checkStep(1)
                                      )),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(width: 7,),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _step = 2;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 25,
                                        color: _checkStep(2),
                                      ),
                                      const SizedBox(height: 3,),
                                      Text("Pack", style: TextStyleMobile.button_14.copyWith(
                                          color: _checkStep(2)
                                      )),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(width: 7,),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _step = 3;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.local_shipping,
                                        size: 25,
                                        color: _checkStep(3),
                                      ),
                                      const SizedBox(height: 3,),
                                      Text("Ship", style: TextStyleMobile.button_14.copyWith(
                                          color: _checkStep(3)
                                      )),
                                    ],
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                      Consumer<GlobalState>(
                          builder: (context, state, child) {
                            return Container(
                              padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                              height: 65,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        child: TextField(
                                          onChanged: (value) {
                                            state.searchkey = value;
                                            state.refresh(context);
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              hintText: "Search by customer no, name, business type,...",
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
                                      )
                                  ),
                                  const SizedBox(width: 10,),
                                  IconButton(
                                      onPressed: (){

                                      },
                                      icon: const Icon(Icons.filter_list),
                                      style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                          )),
                                          side: const MaterialStatePropertyAll(BorderSide(
                                              style: BorderStyle.solid,
                                              width: 1
                                          )),
                                        backgroundColor: MaterialStateProperty.all(Colors.white)
                                      )
                                  )
                                ],
                              ),
                            );
                          },
                      ),
                      Expanded(
                          child: renderView()
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

