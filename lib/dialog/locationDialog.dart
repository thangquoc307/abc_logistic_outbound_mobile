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
    TextEditingController add1Controller = TextEditingController(
        text: initValue.addressOne
    );
    TextEditingController add2Controller = TextEditingController(
        text: initValue.addressTwo
    );
    TextEditingController cityController = TextEditingController(
        text: initValue.city
    );
    TextEditingController stateController = TextEditingController(
        text: initValue.state
    );
    TextEditingController zipCodeController = TextEditingController(
        text: initValue.zipCode
    );
    TextEditingController countryController = TextEditingController(
        text: initValue.country
    );
    final double widthDialog = MediaQuery.of(context).size.width;
    return AlertDialog(
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
          width: widthDialog,
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
                  controller: add1Controller,
                  validator: (value) => Utils.validateRequire(value, "Address 1"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
                  controller: add2Controller,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
                  controller: cityController,
                  validator: (value) => Utils.validateRequire(value, "City"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
                  controller: stateController,
                  validator: (value) => Utils.validateRequire(value, "State"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
                  controller: zipCodeController,
                  validator: (value) => Utils.validateRequire(value, "Zip code"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
                  controller: countryController,
                  validator: (value) => Utils.validateRequire(value, "Country"),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputStyle.inputTextForm,
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
              result['add1'] = add1Controller.text;
              result['add2'] = add2Controller.text;
              result['city'] = cityController.text;
              result['state'] = stateController.text;
              result['zipcode'] = zipCodeController.text;
              result['country'] = countryController.text;

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
