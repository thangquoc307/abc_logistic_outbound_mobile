import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../dialog/reviewPicked.dart';
import '../model/globalState.dart';
import '../service/util.dart';

class PickedList extends StatefulWidget {
  const PickedList({super.key});

  @override
  State<PickedList> createState() => _PickedListState();
}

class _PickedListState extends State<PickedList> {

  @override
  Widget build(BuildContext context) {
    var init = Provider.of<GlobalState>(context, listen: false);
    init.setCountItemOutboundDisplay(context);
    init.getPickedListDatabase();

    return Consumer<GlobalState>(
      builder: (context, state, child) {
        List list = List.from(state.pickedList);
        for (var i = state.countItemOutboundDisplay; i > state.pickedList.length; i--){
          list.add(null);
        }

        return Column(
          children: [
            Expanded(
              child: state.pickedList.isEmpty ? Text("No Data !",
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
                              return ReviewPickedDialog(
                                outboundProductDetailDto: e,
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                              Expanded(
                                child: Container(
                                width: double.infinity,
                                margin: const EdgeInsetsDirectional.only(bottom: 5),
                                  decoration: MobileButton.itemOfList,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: MobileColor.grayButtonColor,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Image.asset(
                                            'assets/images/Vector.png'),
                                      ),
                                    ),
                                    Expanded(child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(e.productName ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyleMobile.h2_12,),
                                          Text("SKU: ${e.sku}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyleMobile.body_12,),
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(text: "Unit QTY: ",
                                                      style: TextStyleMobile.body_12
                                                          .copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                    TextSpan(text: e.pickedQty.toString(),
                                                      style: TextStyleMobile.h2_12
                                                          .copyWith(
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      width: 30,
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 10),
                                      child: const Icon(Icons.location_on_outlined,
                                          color: Colors.grey, size: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },).toList()
              ),
            ),
            Utils.renderPageButton([state.pagePickList, state.totalPagePickList],
                    (value) {state.statePagePickList(value);})
          ],
        );
      },
    );
  }
}
