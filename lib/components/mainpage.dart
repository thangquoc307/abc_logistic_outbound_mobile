import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/components/orderList.dart';
import 'package:flutter_outbound/components/packedList.dart';
import 'package:flutter_outbound/components/pickedList.dart';
import 'package:flutter_outbound/components/shipList.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: MobileColor.orangeColor,
            title: Image.asset('assets/images/logo1.png'),
            actions: const [
              Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: 20,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "OUTBOUND ORDER INFORMATION",
                        style: TextStyleMobile.h1_14.copyWith(
                            color: MobileColor.orangeColor
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
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
                      TabBar(
                          labelColor: Colors.orange,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.orange,
                          labelStyle: TextStyleMobile.button_14,
                          tabs: [
                            Tab(child: Column(
                              children: [
                                const Icon(Icons.view_list, size: 20),
                                const SizedBox(height: 3,),
                                Text("Order", style: TextStyleMobile.button_14),
                              ],
                            )),
                            Tab(child: Column(
                              children: [
                                const Icon(Icons.shelves, size: 20),
                                const SizedBox(height: 3,),
                                Text("Pick", style: TextStyleMobile.button_14),
                              ],
                            )),
                            Tab(child: Column(
                              children: [
                                const Icon(Icons.inventory, size: 20),
                                const SizedBox(height: 3,),
                                Text("Pack", style: TextStyleMobile.button_14),
                              ],
                            )),
                            Tab(child: Column(
                              children: [
                                const Icon(Icons.local_shipping, size: 20),
                                const SizedBox(height: 3,),
                                Text("Ship", style: TextStyleMobile.button_14),
                              ],
                            )),
                          ]
                      ),
                      Consumer<GlobalState>(
                          builder: (context, state, child) {
                            return Container(
                              padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                              height: 65,
                              child: Row(
                                children: [
                                  Expanded(
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
                                      )
                                  ),
                                  const SizedBox(width: 10,),
                                  IconButton(
                                      onPressed: (){

                                      },
                                      icon: const Icon(Icons.filter_list),
                                      style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          )),
                                          side: const MaterialStatePropertyAll(BorderSide(
                                              color: Colors.grey,
                                              style: BorderStyle.solid,
                                              width: 1
                                          ))
                                      )
                                  )
                                ],
                              ),
                            );
                          },
                      ),
                      const Expanded(
                          child: TabBarView(
                            children: [
                              OrderOutboundList(),
                              PickedList(),
                              PackedList(),
                              OutboundShippedList(),
                            ],
                          )
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

