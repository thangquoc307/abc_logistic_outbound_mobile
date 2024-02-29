import 'package:flutter/material.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';
import '../model/shipping.dart';
import '../service/stepRender.dart';
import '../service/util.dart';

class ReviewShippingDialog extends StatefulWidget {
  const ReviewShippingDialog({super.key, required this.shipping});
  final Shipping shipping;

  @override
  State<ReviewShippingDialog> createState() => _ReviewShippingDialogState();
}

class _ReviewShippingDialogState extends State<ReviewShippingDialog> {
  List<int> factorWidth = [2, 3];
  Widget sepa = const SizedBox(width: 20,);

  int step = 0;
  List<Widget>? renderButton() {
    switch (step) {
      case 0:
        return [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel", style: TextStyleMobile.h1_14
                .copyWith(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                step++;
              });
            },
            child: Text("Next", style: TextStyleMobile.h1_14
                .copyWith(color: MobileColor.orangeColor)),
          ),
        ];
      case 1:
        return [
          TextButton(
            onPressed: () {
              setState(() {
                step--;
              });
            },
            child: Text("Back", style: TextStyleMobile.h1_14
                .copyWith(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                step++;
              });
            },
            child: Text("Next", style: TextStyleMobile.h1_14
                .copyWith(color: MobileColor.orangeColor)),
          ),
        ];
      case 2:
        return [
          TextButton(
            onPressed: () {
              setState(() {
                step--;
              });
            },
            child: Text("Back", style: TextStyleMobile.h1_14
                .copyWith(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close", style: TextStyleMobile.h1_14
                .copyWith(color: MobileColor.orangeColor)),
          ),
        ];
    }
  }
  Widget? renderForm() {
    switch (step) {
      case 0:
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              height: 35,
              width: double.infinity,
              color: MobileColor.grayButtonColor,
              child: Text("SENDING ADDRESS",
                  style: TextStyleMobile.h1_14.copyWith(
                      color: Colors.grey
                  )
              ),
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Sender",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.sender ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Ship from",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${widget.shipping.shipFromAddress?.addressOne}, "
                          "${widget.shipping.shipFromAddress?.addressTwo}, "
                          "${widget.shipping.shipFromAddress?.city}, "
                          "${widget.shipping.shipFromAddress?.state}, "
                          "${widget.shipping.shipFromAddress?.zipCode}, "
                          "${widget.shipping.shipFromAddress?.country}"
                          ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Phone",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.phoneSender ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Email",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.emailSender ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            InputStyle.offsetForm,
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              height: 35,
              width: double.infinity,
              color: MobileColor.grayButtonColor,
              child: Text("RECEIVING ADDRESS",
                  style: TextStyleMobile.button_14.copyWith(
                      color: Colors.grey
                  )
              ),
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Receiver",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.receiver ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Ship to",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${widget.shipping.shipToAddress?.addressOne}, "
                          "${widget.shipping.shipToAddress?.addressTwo}, "
                          "${widget.shipping.shipToAddress?.city}, "
                          "${widget.shipping.shipToAddress?.state}, "
                          "${widget.shipping.shipToAddress?.zipCode}, "
                          "${widget.shipping.shipToAddress?.country}"
                          ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Phone",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.phoneReceiver ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Email",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.emailReceiver ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Create Date",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Utils.convertTime(widget.shipping.createdDate),
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Delivery Status",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.deliveryStatus ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Shipped Date",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                          TextSpan(text: " *",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.red)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Utils.convertTime(widget.shipping.shippedDate),
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Estimated Delivery Date",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Utils.convertTime(widget.shipping.estimatedDeliveryDate),
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Shipment Identification Number",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.identificationNumber ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Carrier/Forwarder",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.carrier ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Shipping Amount",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.shippingAmount?.toString() ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Shipment Method",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.shipmentMethod ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Description",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.description ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Invoice Number",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.invoiceNumber?.toString() ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Tax Number",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.taxNumber ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: factorWidth[0],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Bill Number",
                              style: TextStyleMobile.button_14.
                              copyWith(color: Colors.grey)
                          ),
                        ]
                    )),
                  ),
                ),
                sepa,
                Expanded(
                    flex: factorWidth[1],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.shipping.billNumber ?? "",
                          style: TextStyleMobile.button_14),
                    )
                )
              ],
            ),
            InputStyle.offsetForm,

          ],
        );
      case 2:
        return Column(
            children: widget.shipping.shippingPackages?.map((e) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 85,
                  decoration: BoxDecoration(
                      color: MobileColor.softOrangeColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: MobileColor.orangeColor,
                          width: 2
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(e.outboundPackage!.name!, style: TextStyleMobile.button_14.copyWith(
                          color: MobileColor.orangeColor,),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Tracking no:",
                                  style: TextStyleMobile.body_14.copyWith(
                                      color: Colors.grey
                                  ),
                                )
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: e.outboundPackage!.trackingNo,
                                  decoration: InputStyle.inputTextForm,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ).toList() ?? [
              Text("No package has been selected !!!", style: TextStyleMobile.button_14,)
            ]
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
      titlePadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      surfaceTintColor: Colors.white,
      title: Text("RECEIVER",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      actions: renderButton(),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.8),
            StepRenderCustom.stepRender(
                ["Sending and\nreceiving",
                  "Delivery\ninformation", "Add Package\n"],
                step, context),
            InputStyle.offsetForm,
            Expanded(
              child: SingleChildScrollView(
                child: renderForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
