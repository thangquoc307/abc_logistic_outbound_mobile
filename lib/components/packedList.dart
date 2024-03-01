import 'package:flutter/material.dart';
import 'package:flutter_outbound/dialog/reviewPacked.dart';
import 'package:provider/provider.dart';
import '../cascadeStyle/button.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../model/globalState.dart';
import '../service/util.dart';

class PackedList extends StatefulWidget {
  const PackedList({super.key});

  @override
  State<PackedList> createState() => _PackedListState();
}

class _PackedListState extends State<PackedList> {

  @override
  Widget build(BuildContext context) {
    var init = Provider.of<GlobalState>(context, listen: false);
    init.setCountItemOutboundDisplay(context);
    init.getPackedListDatabase();

    return Consumer<GlobalState>(
      builder: (context, state, child) {
        List list = List.from(state.packedList);
        for (var i = state.countItemOutboundDisplay; i > state.packedList.length; i--){
          list.add(null);
        }

        return Column(
          children: [
            Expanded(
              child: state.packedList.isEmpty ? Text("No Data !",
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
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
            Utils.renderPageButton([state.pagePackList, state.totalPagePackList],
                    (value) {state.statePagePackList(value);})
          ],
        );
      },
    );
  }
}
