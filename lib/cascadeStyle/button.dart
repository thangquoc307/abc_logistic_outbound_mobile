import 'package:flutter/material.dart';

class MobileButton {
  static const BoxDecoration buttonPage = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static const ButtonStyle buttonPageStyle = ButtonStyle(
    alignment: Alignment.center,
    padding: MaterialStatePropertyAll(EdgeInsets.zero)
  );
  static const BoxDecoration itemOfList = BoxDecoration(
    color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}