import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/service/util.dart';

import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';
import '../cascadeStyle/input.dart';
import '../model/shippingAddress.dart';
import '../service/stepRender.dart';
import 'locationDialog.dart';

class AddReceiverDialog extends StatefulWidget {
  const AddReceiverDialog({super.key, required this.shipping});
  final Shipping shipping;

  @override
  State<AddReceiverDialog> createState() => _AddReceiverDialogState();
}

class _AddReceiverDialogState extends State<AddReceiverDialog> {
  int step = 0;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  static const List<String> _deliveryStatus = ["pending", "shipped", "delivered", "cancelled",];
  static const List<String> _carrier = ["FEDEX", "UPS", "USPS", "DHL", "AMAZON", "OTHERS"];
  static const List<String> _shipmentMethod = ["FEDEX", "UPS", "USPS", "DHL", "AMAZON", "OTHERS"];

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
              if(_formKey1.currentState!.validate()) {
                setState(() {
                  step++;
                });
              }
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
              if(_formKey2.currentState!.validate()) {
                setState(() {
                  step++;
                });
              }
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
              if(_formKey3.currentState!.validate()) {
                //save
                Navigator.of(context).pop();
              }
            },
            child: Text("Save", style: TextStyleMobile.h1_14
                .copyWith(color: MobileColor.orangeColor)),
          ),
        ];
    }
  }

  Widget? renderForm() {
    print(widget.shipping.carrier);
    switch (step) {
      case 0:
        return Form(
          key: _formKey1,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
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
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Sender",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.sender,
                validator: (value) => Utils.validateRequire(value, "Sender"),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.sender = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Ship from",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                  validator: (value) => Utils.validateLocation(value, "Ship from"),
                  controller: TextEditingController(
                      text:
                      "${widget.shipping.shipFromAddress?.addressOne ?? ''}, "
                          "${widget.shipping.shipFromAddress?.addressTwo ?? ''}, "
                          "${widget.shipping.shipFromAddress?.city ?? ''}, "
                          "${widget.shipping.shipFromAddress?.state ?? ''}, "
                          "${widget.shipping.shipFromAddress?.zipCode ?? ''}, "
                          "${widget.shipping.shipFromAddress?.country ?? ''}"
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BillingDialog(dataSubmit: (Map<String, String> map) {
                          setState(() {
                            widget.shipping.shipFromAddress = ShippingAddress(null,
                                map['add1'], map['add2'],
                                map['city'], map['state'],
                                map['zipcode'], map['country']);
                          });
                        }, initValue: widget.shipping.shipFromAddress,);
                      },
                    );
                  },
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Phone",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.phoneSender,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.phoneSender = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Email",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.emailSender,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.emailSender = value;
                },
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
                    style: TextStyleMobile.h1_14.copyWith(
                        color: Colors.grey
                    )
                ),
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Recipient's name",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.receiver,
                validator: (value) => Utils.validateRequire(value, "Recipient's name"),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.receiver = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Ship to",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                  validator: (value) => Utils.validateLocation(value, "Ship to"),
                  controller: TextEditingController(
                      text:
                      "${widget.shipping.shipToAddress?.addressOne ?? ''}, "
                          "${widget.shipping.shipToAddress?.addressTwo ?? ''}, "
                          "${widget.shipping.shipToAddress?.city ?? ''}, "
                          "${widget.shipping.shipToAddress?.state ?? ''}, "
                          "${widget.shipping.shipToAddress?.zipCode ?? ''}, "
                          "${widget.shipping.shipToAddress?.country ?? ''}"
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BillingDialog(dataSubmit: (Map<String, String> map) {
                          setState(() {
                            widget.shipping.shipToAddress = ShippingAddress(null,
                                map['add1'], map['add2'],
                                map['city'], map['state'],
                                map['zipcode'], map['country']);
                          });
                        }, initValue: widget.shipping.shipToAddress,);
                      },
                    );
                  },
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Phone",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.phoneReceiver,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.phoneReceiver = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Email",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.emailReceiver,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.emailSender = value;
                },
              ),


            ],
          ),
        );
      case 1:
        return Form(
          key: _formKey2,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Create Date",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: Utils.convertTime(widget.shipping.createdDate),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.dateForm,
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Delivery Status",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              DropdownButtonFormField<String>(
                value: widget.shipping.deliveryStatus?.toUpperCase(),
                hint: const Text("Select delivery status"),
                decoration: InputStyle.inputTextForm,
                items: _deliveryStatus.map((String e) {
                  return DropdownMenuItem<String>(
                    value: e.toUpperCase(),
                    child: Text(e),
                  );
                }).toList(),
                validator: (value) => Utils.validateRequire(value, "Delivery Status"),
                onChanged: (String? value) {
                  widget.shipping.deliveryStatus = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Shipped Date",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              InkWell(
                onTap: () async {
                  DateTime? result = await Utils.selectDate(context, widget.shipping.shippedDate);
                  if (result != null) {
                    setState(() {
                      widget.shipping.shippedDate = result;
                    });
                  }
                },
                child: TextFormField(
                  controller: TextEditingController(
                      text: Utils.convertTime(widget.shipping.shippedDate)
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.dateForm,
                ),
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Estimated Delivery Date",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              InkWell(
                onTap: () async {
                  DateTime? result = await Utils.selectDate(context, widget.shipping.estimatedDeliveryDate);
                  if (result != null) {
                    setState(() {
                      widget.shipping.estimatedDeliveryDate = result;
                    });
                  }
                },
                child: TextFormField(
                  controller: TextEditingController(
                      text: Utils.convertTime(widget.shipping.estimatedDeliveryDate)
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.dateForm,
                ),
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Carrier/Forwarder",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              DropdownButtonFormField<String>(
                value: widget.shipping.carrier?.toUpperCase(),
                hint: const Text("Select carrier/forwarder"),
                decoration: InputStyle.inputTextForm,
                items: _carrier.map((String e) {
                  return DropdownMenuItem<String>(
                    value: e.toUpperCase(),
                    child: Text(e),
                  );
                }).toList(),
                validator: (value) => Utils.validateRequire(value, "carrier/forwarder"),
                onChanged: (String? value) {
                  widget.shipping.carrier = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Shipment Method",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                      TextSpan(text: " *",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.red)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              DropdownButtonFormField<String>(
                value: widget.shipping.shipmentMethod?.toUpperCase(),
                hint: const Text("Select shipment method"),
                decoration: InputStyle.inputTextForm,
                items: _shipmentMethod.map((String e) {
                  return DropdownMenuItem<String>(
                    value: e.toUpperCase(),
                    child: Text(e),
                  );
                }).toList(),
                validator: (value) => Utils.validateRequire(value, "shipment method"),
                onChanged: (String? value) {
                  widget.shipping.shipmentMethod = value;
                },
              ),
              InputStyle.offsetForm,
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Shipping Amount",
                          style: TextStyleMobile.h1_14.
                          copyWith(color: Colors.black)
                      ),
                    ]
                )),
              ),
              InputStyle.offsetText,
              TextFormField(
                initialValue: widget.shipping.shippingAmount == null
                    ? "" : widget.shipping.shippingAmount.toString(),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputStyle.inputTextForm,
                onChanged: (value) {
                  widget.shipping.shippingAmount = double.parse(value);
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              InputStyle.offsetForm,
            ],
          ),
        );
      case 2:

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
      title: Text("ADD  A RECEIVER",
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
                ["Sending and\nreceiving information",
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
