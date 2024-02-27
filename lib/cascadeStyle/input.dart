import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';

class InputStyle {
  static final InputDecoration inputTextForm = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey,)
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,)
    ),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,)
    ),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,)
    ),
    labelStyle: TextStyleMobile.body_14,
    hintStyle: TextStyleMobile.body_14,
  );
  static final InputDecoration lockTextForm = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      enabled: false,
      suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,)
      ),
    labelStyle: TextStyleMobile.body_14,
    hintStyle: TextStyleMobile.body_14,
  );
  static final InputDecoration dateForm = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    enabled: false,
    suffixIcon: const Icon(Icons.calendar_month_rounded, color: Colors.grey),
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,)
    ),
    labelStyle: TextStyleMobile.body_14,
    hintStyle: TextStyleMobile.body_14,
  );
  static final InputDecoration qtyTextForm = InputDecoration(
    alignLabelWithHint: true,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide.none
    ),
    focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none
    ),
    errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none
    ),
    focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none
    ),
    labelStyle: TextStyleMobile.body_10,
    hintStyle: TextStyleMobile.body_10,
  );
  static const Widget offsetText = SizedBox(height: 5,);
  static const Widget offsetForm = SizedBox(height: 15,);
}