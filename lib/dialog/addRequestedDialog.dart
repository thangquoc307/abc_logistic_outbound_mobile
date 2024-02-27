import 'package:flutter/material.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';
import '../model/outboundProductDetails.dart';
import '../model/product.dart';

class AddRequestedDialog extends StatelessWidget {
  const AddRequestedDialog({super.key});
  bool isCheckedItem(Product item, Set<OutboundProductDetail>? set) {
    if (set != null) {
      return set.any((element) => element.product?.id == item.id);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(bottom:  0, left:  20, top: 0, right: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close, color: Colors.grey,)
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("SELECT PRODUCTS",
                style: TextStyleMobile.h1_14
                    .copyWith(
                    color: MobileColor.orangeColor
                )
            ),
          ),
        ],
      ),
      content: Column(
        children: [
            TextField(
              onChanged: (value) {

              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search UPC",
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
          ),
          InputStyle.offsetForm,
          SingleChildScrollView(
            child: Consumer<GlobalState>(
              builder: (context, state, child) {
                return Column(
                  children: state.productList.map((e) {
                    return isCheckedItem(e, state.objectForm.outboundProductDetails) ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      height: 65,
                      decoration: BoxDecoration(
                          color: MobileColor.softOrangeColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: e.name?.trim(),
                                    style: TextStyleMobile.h2_12.copyWith(color: Colors.black)
                                  ),
                                  TextSpan(
                                    text: " added to application",
                                      style: TextStyleMobile.body_12.copyWith(color: Colors.black)
                                  )
                                ]
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          TextButton(
                              onPressed: () {
                                state.delRequestProduct(e);
                              },
                              child: Text("Cancel",
                                  style: TextStyleMobile.button_14.copyWith(
                                      color: MobileColor.orangeColor)
                              )
                          )
                        ],
                      ),
                    ) : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      height: 80,
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: MobileColor.grayButtonColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Image.asset('assets/images/Vector.png'),
                            ),
                          ),
                          Expanded(child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(e.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyleMobile.h2_12,),
                                Text("SKU: ${e.skus?[0].name}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyleMobile.body_12,),
                                Text("UPC: ${e.upc}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyleMobile.body_12,),
                              ],
                            ),
                          )),
                          SizedBox(
                            width: 40,
                            child: IconButton(
                                onPressed: () {
                                  state.addRequestProduct(e);
                                },
                                icon: const Icon(Icons.add, color: MobileColor.orangeColor)
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            )
          )
        ],
      ),
    );
  }
}
