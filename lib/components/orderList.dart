import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/button.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

class OrderOutboundList extends StatefulWidget {
  const OrderOutboundList({super.key});

  @override
  State<OrderOutboundList> createState() => _OrderOutboundListState();
}

class _OrderOutboundListState extends State<OrderOutboundList> {
  static const double spaceBetween = 3;
  static const double sizePageButton = 30;

  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalState>(context, listen: false).getOrderListDatabase(context);

    return Consumer<GlobalState>(
        builder: (context, state, child) {
          return Column(
            children: [
              Expanded(
                child: state.outboundList.isEmpty ? Text("No Data !",
                  style: TextStyleMobile.h1_14,) :
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: state.outboundList.map((e) {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            state.setupFormEdit(e);
                            Navigator.pushNamed(context, "/create");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: MobileButton.itemOfList,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.feed,
                                            color: MobileColor.orangeColor,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(e.orderNo ?? "")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.supervisor_account,
                                            color: MobileColor.orangeColor,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(e.issuser ?? "")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: (e.status == "OPEN")
                                                    ? MobileColor.greenButtonColor
                                                    : MobileColor.grayButtonColor,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: (e.status == "OPEN")
                                                ? Text("Open", style: TextStyleMobile.button_14.copyWith(
                                                color: Colors.white))
                                                : Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                              child: Text("Acknowledged",
                                                style: TextStyleMobile.button_14.copyWith(
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(Utils.convertTime(e.createdDate),
                                        style: TextStyleMobile.body_12,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },).toList()
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: (state.pageOrderList > 0) ? () {
                            state.statePageOrderList(0, context);
                          } : null,
                          style: MobileButton.buttonPageStyle,
                          child: Text("<<",
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: (state.pageOrderList > 0) ? () {
                            state.statePageOrderList(state.pageOrderList - 1, context);
                          } : null,
                          style: MobileButton.buttonPageStyle,
                          child: Text("<",
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ),
                    (state.pageOrderList - 1 > 0 && state.pageOrderList == state.totalPageOrderList - 1) ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: 30,
                      height: 30,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: () {
                            state.statePageOrderList(state.pageOrderList - 2, context);

                          },
                          style: MobileButton.buttonPageStyle,
                          child: Text((state.pageOrderList - 1).toString(),
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ) : const SizedBox(),
                    (state.pageOrderList > 0) ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: 30,
                      height: 30,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: () {
                            state.statePageOrderList(state.pageOrderList - 1, context);
                          },
                          style: MobileButton.buttonPageStyle,
                          child: Text(state.pageOrderList.toString(),
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ) : const SizedBox(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.orangeColor
                      ),
                      child: TextButton(
                          onPressed: () {},
                          style: MobileButton.buttonPageStyle,
                          child: Text((state.pageOrderList + 1).toString(),
                              style: TextStyleMobile.button_14.copyWith(
                                  color: Colors.white
                              )
                          )
                      ),
                    ),
                    (state.pageOrderList + 1 < state.totalPageOrderList) ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: () {
                            state.statePageOrderList(state.pageOrderList + 1, context);
                          },
                          style: MobileButton.buttonPageStyle,
                          child: Text((state.pageOrderList + 2).toString(),
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ) : const SizedBox(),
                    (state.pageOrderList + 2 < state.totalPageOrderList && state.pageOrderList == 0) ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: () {
                            state.statePageOrderList(state.pageOrderList + 2, context);
                          },
                          style: MobileButton.buttonPageStyle,
                          child: Text((state.pageOrderList + 3).toString(),
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ) : const SizedBox(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: (state.pageOrderList + 1 < state.totalPageOrderList) ? () {
                            state.statePageOrderList(state.pageOrderList + 1, context);
                          } : null,
                          style: MobileButton.buttonPageStyle,
                          child: Text(">",
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                      width: sizePageButton,
                      height: sizePageButton,
                      decoration: MobileButton.buttonPage.copyWith(
                          color: MobileColor.grayButtonColor
                      ),
                      child: TextButton(
                          onPressed: (state.pageOrderList + 1 < state.totalPageOrderList) ? () {
                            state.statePageOrderList(state.totalPageOrderList - 1, context);
                          } : null,
                          style: MobileButton.buttonPageStyle,
                          child: Text(">>",
                              style: TextStyleMobile.button_14
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
    );
  }
}
