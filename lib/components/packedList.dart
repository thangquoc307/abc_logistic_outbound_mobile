import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/globalState.dart';

class PackedList extends StatefulWidget {
  const PackedList({super.key});

  @override
  State<PackedList> createState() => _PackedListState();
}

class _PackedListState extends State<PackedList> {
  static const double spaceBetween = 3;
  static const double sizePageButton = 30;

  @override
  Widget build(BuildContext context) {
    var init = Provider.of<GlobalState>(context, listen: false);
    init.setCountItemOutboundDisplay(context);
    init.getPackedListDatabase();

    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return Column(
          children: [
            Expanded(
              child: state.packedList.isEmpty ? Text("No Data !",
                style: TextStyleMobile.h1_14,) :
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: state.packedList.map((e) {
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
                                      Text(e.name ?? "")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.supervisor_account,
                                        color: MobileColor.orangeColor,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(e.customerName ?? "", overflow: TextOverflow.ellipsis, maxLines: 1,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 90,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: "- WxHxL ",
                                                    style: TextStyleMobile.body_10.copyWith(color: Colors.black)),
                                                TextSpan(text: "(${state.dimensiontUnit[e.dimensionId]})",
                                                    style: TextStyleMobile.lable_12.copyWith(color: Colors.black)),
                                              ]
                                          ),
                                        )
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: (e.pWidth != -1 || e.pHeight != -1 || e.pWeight != -1)
                                          ? RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(text: e.pWidth.toString(),
                                                    style: TextStyleMobile.h2_12
                                                        .copyWith(color: Colors.green)),
                                                TextSpan(text: "x",
                                                    style: TextStyleMobile.body_10
                                                        .copyWith(color: Colors.green)),
                                                TextSpan(text: e.pHeight.toString(),
                                                    style: TextStyleMobile.h2_12
                                                        .copyWith(color: Colors.green)),
                                                TextSpan(text: "x",
                                                    style: TextStyleMobile.body_10
                                                        .copyWith(color: Colors.green)),
                                                TextSpan(text: e.pLength.toString(),
                                                    style: TextStyleMobile.h2_12
                                                        .copyWith(color: Colors.green)),
                                              ]
                                            ),
                                          )
                                          : Text("No data",
                                          style: TextStyleMobile.h2_12
                                            .copyWith(color: Colors.red))
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(text: "- Weight ",
                                                style: TextStyleMobile.body_10.copyWith(color: Colors.black)),
                                            TextSpan(text: "(${state.weightUnit[e.weightId]})",
                                                style: TextStyleMobile.lable_12.copyWith(color: Colors.black)),
                                          ]
                                        ),
                                      )
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: e.pWeight != -1 ? Text("${e.pWeight}",
                                          style: TextStyleMobile.h2_12
                                              .copyWith(color: Colors.green))
                                      : Text("No data",
                                          style: TextStyleMobile.h2_12
                                              .copyWith(color: Colors.red)),
                                    ),
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
                        onPressed: (state.pagePackList > 0) ? () {
                          state.statePagePackList(0, context);
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
                        onPressed: (state.pagePackList > 0) ? () {
                          state.statePagePackList(state.pagePackList - 1, context);
                        } : null,
                        style: MobileButton.buttonPageStyle,
                        child: Text("<",
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ),
                  (state.pagePackList - 1 > 0 && state.pagePackList == state.totalPagePackList - 1) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePackList(state.pagePackList - 2, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePackList - 1).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  (state.pagePackList > 0) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: 30,
                    height: 30,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePackList(state.pagePackList - 1, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text(state.pagePackList.toString(),
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
                        child: Text((state.pagePackList + 1).toString(),
                            style: TextStyleMobile.button_14.copyWith(
                                color: Colors.white
                            )
                        )
                    ),
                  ),
                  (state.pagePackList + 1 < state.totalPagePackList) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePackList(state.pagePackList + 1, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePackList + 2).toString(),
                            style: TextStyleMobile.button_14
                        )
                    ),
                  ) : const SizedBox(),
                  (state.pagePackList + 2 < state.totalPagePackList && state.pagePackList == 0) ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
                    width: sizePageButton,
                    height: sizePageButton,
                    decoration: MobileButton.buttonPage.copyWith(
                        color: MobileColor.grayButtonColor
                    ),
                    child: TextButton(
                        onPressed: () {
                          state.statePagePackList(state.pagePackList + 2, context);
                        },
                        style: MobileButton.buttonPageStyle,
                        child: Text((state.pagePackList + 3).toString(),
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
                        onPressed: (state.pagePackList + 1 < state.totalPagePackList) ? () {
                          state.statePagePackList(state.pagePackList + 1, context);
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
                        onPressed: (state.pagePackList + 1 < state.totalPagePackList) ? () {
                          state.statePagePackList(state.totalPagePackList - 1, context);
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
