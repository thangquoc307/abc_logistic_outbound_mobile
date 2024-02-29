import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/reviewPacked.dart';
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
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ReviewPackageDialog(outboundPackedDto: e,);
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: MobileColor.softOrangeColor,
                            border: Border.all(
                              color: MobileColor.orangeColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(e.name ?? "",
                                    style: TextStyleMobile.body_14,
                                  )
                              ),
                              const Icon(Icons.print_outlined, color: MobileColor.orangeColor,)
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
