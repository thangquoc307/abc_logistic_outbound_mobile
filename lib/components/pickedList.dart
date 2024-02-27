import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/globalState.dart';

class PickedList extends StatefulWidget {
  const PickedList({super.key});

  @override
  State<PickedList> createState() => _PickedListState();
}

class _PickedListState extends State<PickedList> {
  static const double spaceBetween = 3;
  static const double sizePageButton = 30;

  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalState>(context, listen: false).getPickedListDatabase(context);

    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return Column(
          children: [
            Expanded(
              child: state.pickedList.isEmpty ? Text("No Data !",
                style: TextStyleMobile.h1_14,) :
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: state.pickedList.map((e) {
                    print(e);
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
                                      Text(e.customerProjectNo ?? "", overflow: TextOverflow.ellipsis, maxLines: 1,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 100,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: "Picked Qty: ",
                                            style: TextStyleMobile.body_10.copyWith(color: Colors.black)),
                                        TextSpan(text: e.pickedQty.toString(),
                                            style: e.pickedQty == 0
                                                ? TextStyleMobile.h2_12.copyWith(color: Colors.red)
                                                : TextStyleMobile.h2_12.copyWith(color: Colors.green)
                                        ),
                                      ]
                                    )),
                                  ),
                                  Expanded(
                                    child: RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text: "Packed Qty: ",
                                              style: TextStyleMobile.body_10.copyWith(color: Colors.black)),
                                          TextSpan(text: e.packagedQty.toString(),
                                              style: e.packagedQty == 0
                                                  ? TextStyleMobile.h2_12.copyWith(color: Colors.red)
                                                  : TextStyleMobile.h2_12.copyWith(color: Colors.green)
                                          ),
                                        ]
                                    )),
                                  ),
                                  Expanded(
                                    child: RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text: "Shipped Qty: ",
                                              style: TextStyleMobile.body_10.copyWith(color: Colors.black)),
                                          TextSpan(text: e.shippedQty.toString(),
                                              style: e.shippedQty == 0
                                              ? TextStyleMobile.h2_12.copyWith(color: Colors.red)
                                              : TextStyleMobile.h2_12.copyWith(color: Colors.green)
                                          ),
                                        ]
                                    )),
                                  ),
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
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: (state.pagePickList > 0) ? () {
                          state.statePagePickList(0, context);
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
                        onPressed: (state.pagePickList > 0) ? () {
                          state.statePagePickList(state.pagePickList - 1, context);
                        } : null,
                        style: MobileButton.buttonPageStyle,
                        child: Text("<",
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ),
                  (state.pagePickList - 1 > 0 && state.pagePickList == state.totalPagePickList - 1) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePickList(state.pagePickList - 2, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePickList - 1).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  (state.pagePickList > 0) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePickList(state.pagePickList - 1, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text(state.pagePickList.toString(),
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
                        child: Text((state.pagePickList + 1).toString(),
                            style: TextStyleMobile.button_14.copyWith(
                                color: Colors.white
                            )
                        )
                    ),
                  ),
                  (state.pagePickList + 1 < state.totalPagePickList) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePickList(state.pagePickList + 1, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePickList + 2).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  (state.pagePickList + 2 < state.totalPagePickList && state.pagePickList == 0) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePickList(state.pagePickList + 2, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePickList + 3).toString(),
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
                        onPressed: (state.pagePickList + 1 < state.totalPagePickList) ? () {
                          state.statePagePickList(state.pagePickList + 1, context);
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
                        onPressed: (state.pagePickList + 1 < state.totalPagePickList) ? () {
                          state.statePagePickList(state.totalPagePickList - 1, context);
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
