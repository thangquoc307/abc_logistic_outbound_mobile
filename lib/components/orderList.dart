import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/button.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:flutter_outbound/service/util.dart';
import 'package:provider/provider.dart';

class OrderOutboundList extends StatelessWidget {
  const OrderOutboundList({super.key});
  @override
  Widget build(BuildContext context) {
    var init = Provider.of<GlobalState>(context, listen: false);
    init.setCountItemOutboundDisplay(context);
    init.getOrderListDatabase();

    return Consumer<GlobalState>(
        builder: (context, state, child) {
          List list = List.from(state.outboundList);
          for (var i = state.countItemOutboundDisplay; i > state.outboundList.length; i--){
            list.add(null);
          }

          return Column(
            children: [
              Expanded(
                child: state.outboundList.isEmpty ? Text("No Data !",
                  style: TextStyleMobile.h1_14,) :
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: list.map((e) {
                      if (e == null) {
                        return const Expanded(child: SizedBox());
                      }
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            state.setupFormEdit(e);
                            Navigator.pushNamed(context, "/create");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: MobileButton.itemOfList,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.feed,
                                            color: MobileColor.orangeColor,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(e.orderNo ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.supervisor_account,
                                            color: MobileColor.orangeColor,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(e.issuser ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
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
                                          alignment: Alignment.centerRight,
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
              Utils.renderPageButton([state.pageOrderList, state.totalPageOrderList],
                      (value) {state.statePageOrderList(value);})
            ],
          );
        },
    );
  }
}