import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
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
        return Column(
          children: [
            Expanded(
              child: state.shippingList.isEmpty ? Text("No Data !",
                style: TextStyleMobile.h1_14,) :
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: state.shippingList.map((e) {
                    return Expanded(
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
                                            borderRadius: BorderRadius
                                                .circular(5)
                                        ),
                                        child: (e.status == "OPEN")
                                            ? Text("Open",
                                            style: TextStyleMobile.button_14
                                                .copyWith(
                                                color: Colors.white))
                                            : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text("Acknowledged",
                                            style: TextStyleMobile.button_14
                                                .copyWith(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: (state.pageShipList > 0) ? () {
                          state.statePageShipList(0, context);
                        } : null,
                        style: MobileButton.buttonPageStyle,
                        child: Text("<<",
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: (state.pageShipList > 0) ? () {
                          state.statePageShipList(state.pageShipList - 1,
                              context);
                        } : null,
                        style: MobileButton.buttonPageStyle,
                        child: Text("<",
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ),
                  (state.pageShipList - 1 > 0 &&
                      state.pageShipList == state.totalPageShipList - 1)
                      ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePageShipList(state.pageShipList - 2,
                              context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pageShipList - 1).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  )
                      : const SizedBox(),
                  (state.pageShipList > 0) ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePageShipList(state.pageShipList - 1,
                              context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text(state.pageShipList.toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.orangeColor
                    ),
                    child: TextButton(
                        onPressed: () {},
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pageShipList + 1).toString(),
                            style: TextStyleMobile.button_14.copyWith(
                                color: Colors.white
                            )
                        )
                    ),
                  ),
                  (state.pageShipList + 1 < state.totalPageShipList)
                      ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePageShipList(state.pageShipList + 1,
                              context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pageShipList + 2).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  )
                      : const SizedBox(),
                  (state.pageShipList + 2 < state.totalPageShipList &&
                      state.pageShipList == 0) ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePageShipList(state.pageShipList + 2,
                              context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pageShipList + 3).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: (state.pageShipList + 1 <
                            state.totalPageShipList) ? () {
                          state.statePageShipList(state.pageShipList + 1,
                              context);
                        } : null,
                        style: MobileButton.buttonPageStyle,
                        child: Text(">",
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: (state.pageShipList + 1 <
                            state.totalPageShipList) ? () {
                          state.statePageShipList(state.totalPageShipList - 1,
                              context);
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
