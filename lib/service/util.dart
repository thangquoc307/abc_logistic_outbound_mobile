import 'package:flutter/material.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';

class Utils {
  static String convertTime(DateTime? time) {
    if (time != null) {
      return
        "${time.day < 10 ? '0' : ''}${time.day}"
            "/${time.month < 10 ? '0' : ''}${time.month}"
            "/${time.year}";
    } else {
      return "";
    }
  }
  static Future<DateTime?> selectDate(BuildContext context, DateTime? initDate) async {
    initDate ??= DateTime.now();
    final DateTime? picker = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
    );
    return picker;
  }
  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: MobileColor.orangeColor,
      content: Text(content, style: TextStyleMobile.body_14.copyWith(color: Colors.white)),));
  }
  static void showSnackBarAlert(BuildContext context, String content) {
    // Fluttertoast.showToast(
    //     msg: content,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP_RIGHT,
    //     timeInSecForIosWeb: 1,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   backgroundColor: MobileColor.orangeColor
    // );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: Colors.red,
      content: Text(content, style: TextStyleMobile.body_14.copyWith(color: Colors.white)),));
  }
  static String? validateRequire(String? value, String name) {
    if (value == null || value.isEmpty) {
      return '$name is required';
    }
    return null;
  }
  static String? validateLocation(String? value, String name) {
    if (value == ", , , , , ") {
      return '$name is required';
    }
    return null;
  }
}