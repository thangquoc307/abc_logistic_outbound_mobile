import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/model/billing.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:provider/provider.dart';

import '../cascadeStyle/input.dart';

class BillingDialog extends StatelessWidget {
  BillingDialog({super.key, required this.dataSubmit, required this.initValue});
  final Function(Map<String, String>) dataSubmit;
  final GlobalKey<FormState> _billingLocationKey = GlobalKey<FormState>();

  final initValue;


  String? _add1Validate(String? value){
    if(value == null || value.isEmpty){
      return 'Address 1 is required';
    }
  }
  String? _cityValidate(String? value){
    if(value == null || value.isEmpty){
      return 'City is required';
    }
  }
  String? _stateValidate(String? value){
    if(value == null || value.isEmpty){
      return 'State is required';
    }
  }
  String? _zipCodeValidate(String? value){
    if(value == null || value.isEmpty){
      return 'Zip code is required';
    }
  }
  String? _countryValidate(String? value){
    if(value == null || value.isEmpty){
      return 'Country is required';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _add1Controller = TextEditingController(
        text: initValue.addressOne
    );
    TextEditingController _add2Controller = TextEditingController(
        text: initValue.addressTwo
    );
    TextEditingController _cityController = TextEditingController(
        text: initValue.city
    );
    TextEditingController _stateController = TextEditingController(
        text: initValue.state
    );
    TextEditingController _zipCodeController = TextEditingController(
        text: initValue.zipCode
    );
    TextEditingController _countryController = TextEditingController(
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
                  controller: _add1Controller,
                  validator: _add1Validate,
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
                  controller: _add2Controller,
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
                  controller: _cityController,
                  validator: _cityValidate,
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
                  controller: _stateController,
                  validator: _stateValidate,
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
                  controller: _zipCodeController,
                  validator: _zipCodeValidate,
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
                  controller: _countryController,
                  validator: _countryValidate,
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
              result['add1'] = _add1Controller.text;
              result['add2'] = _add2Controller.text;
              result['city'] = _cityController.text;
              result['state'] = _stateController.text;
              result['zipcode'] = _zipCodeController.text;
              result['country'] = _countryController.text;

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
