import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../dialog/reviewShipping.dart';
import '../model/globalState.dart';
import '../service/util.dart';

class OutboundShippedList extends StatelessWidget {
  const OutboundShippedList({super.key});
  static const double spaceBetween = 3;
  static const double sizePageButton = 30;

  @override
  Widget build(BuildContext context) {
    var init = Provider.of<GlobalState>(context, listen: false);
    init.setCountItemOutboundDisplay(context);
    init.getShipListDatabase();

    return Consumer<GlobalState>(
      builder: (context, state, child) {
        List list = List.from(state.shippingList);
        for (var i = state.countItemOutboundDisplay; i > state.shippingList.length; i--){
          list.add(null);
        }

        return Column(
          children: [
            Expanded(
              child: state.shippingList.isEmpty ? Text("No Data !",
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ReviewShippingDialog(
                                shipping: e,
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: MobileButton.itemOfList,
                          width: double.infinity,
                          child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image.asset("assets/images/shipItem.png"),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(e.sender ?? "",
                                          style: TextStyleMobile.button_14.copyWith(color: MobileColor.orangeColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("Identification Number: ${e.identificationNumber}",
                                          style: TextStyleMobile.body_12.copyWith(
                                              color: Colors.grey
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("DeliveryStatus: ${e.deliveryStatus}",
                                          style: TextStyleMobile.body_12.copyWith(
                                              color: Colors.grey
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                    );
                  }).toList(),
              ),
            ),
            Utils.renderPageButton([state.pageShipList, state.totalPageShipList],
                    (value) {state.statePageShipList(value);})
          ],
        );
      },
    );
  }
}
