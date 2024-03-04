import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/service/util.dart';
import '../cascadeStyle/input.dart';

class BillingDialog extends StatelessWidget {
  BillingDialog({super.key, required this.dataSubmit, required this.initValue});
  final Function(Map<String, String>) dataSubmit;
  final GlobalKey<FormState> _billingLocationKey = GlobalKey<FormState>();
  final initValue;

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
      title: Text("CHOOSE A LOCATION",
          style: TextStyleMobile.h1_14
              .copyWith(
              color: MobileColor.orangeColor
          )
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _billingLocationKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "Address 1",
                            style: TextStyleMobile.button_14.
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
                  initialValue: initValue.addressOne,
                  validator: (value) => Utils.validateRequire(value, "Address 1"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.addressOne = value;
                  },
                ),
                InputStyle.offsetForm,
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "Address 2",
                            style: TextStyleMobile.button_14.
                            copyWith(color: Colors.black)
                        ),
                      ]
                  )),
                ),
                InputStyle.offsetText,
                TextFormField(
                  initialValue: initValue.addressTwo,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.addressTwo = value;
                  },
                ),
                InputStyle.offsetForm,
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "City",
                            style: TextStyleMobile.button_14.
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
                  initialValue: initValue.city,
                  validator: (value) => Utils.validateRequire(value, "City"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.city = value;
                  },
                ),
                InputStyle.offsetForm,
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "State",
                            style: TextStyleMobile.button_14.
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
                  initialValue: initValue.state,
                  validator: (value) => Utils.validateRequire(value, "State"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.state = value;
                  },
                ),
                InputStyle.offsetForm,
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "Zip code",
                            style: TextStyleMobile.button_14.
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
                  initialValue: initValue.zipCode,
                  validator: Utils.validateZipCode,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.zipCode = value;
                  },
                ),
                InputStyle.offsetForm,
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "Country",
                            style: TextStyleMobile.button_14.
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
                  initialValue: initValue.country,
                  validator: (value) => Utils.validateRequire(value, "Country"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
                  onChanged: (value) {
                    initValue.country = value;
                  },
                ),
                InputStyle.offsetForm,
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if(_billingLocationKey.currentState!.validate()){
              Map<String, String> result = {};
              result['add1'] = initValue.addressOne;
              result['add2'] = initValue.addressTwo ?? "";
              result['city'] = initValue.city;
              result['state'] = initValue.state;
              result['zipcode'] = initValue.zipCode;
              result['country'] = initValue.country;

              dataSubmit(result);
              Navigator.of(context).pop();
            }
          },
          child: Text("Save", style: TextStyleMobile.h1_14
              .copyWith(color: MobileColor.orangeColor)),
        )
      ],
    );
  }
}
