import 'package:flutter/material.dart';
import '../cascadeStyle/button.dart';
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
  static String? validateZipCode(String? value) {
    RegExp regExp = RegExp(r'^\d{5,6}$');

    if (value == null || value.isEmpty) {
      return 'Zip Code is required';
    } else if (!regExp.hasMatch(value!)){
      return 'Zip Code is invalid';
    }
    return null;
  }
  static bool validateDoubleNumber(String? value){
    RegExp regExp = RegExp(r'^\d+\.?\d{0,2}');
    return !(value == null || value.isEmpty) && regExp.hasMatch(value);
  }

  static Widget renderBoxDimension(Widget inbound, Widget unit){
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Expanded(
                child: inbound
            ),
            Container(
              alignment: Alignment.center,
              width: 25,
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  start: BorderSide(
                    color: Colors.grey,
                    width: 1
                  )
                )
              ),
              child: unit,
            )
          ],
        ),
      ),
    );
  }
  static Widget renderPageButton(List<int> listOfPageNumber, Function(int) setupPage) {
    const double spaceBetween = 3;
    const double sizePageButton = 30;

    int page = listOfPageNumber[0];
    int totalPage = listOfPageNumber[1];

    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: (page > 0) ? Colors.white : Colors.grey
              ),
              child: TextButton(
                  onPressed: (page > 0) ? () {
                    setupPage(0);
                  } : null,
                  style: MobileButton.buttonPageStyle,
                  child: Text("<<",
                      style: TextStyleMobile.button_14.copyWith(
                          color: (page > 0) ? Colors.black : MobileColor.grayButtonColor
                      )
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: (page > 0) ? Colors.white : Colors.grey
              ),
              child: TextButton(
                  onPressed: (page > 0) ? () {
                    page--;
                    setupPage(page);
                  } : null,
                  style: MobileButton.buttonPageStyle,
                  child: Text("<",
                      style: TextStyleMobile.button_14.copyWith(
                          color: (page > 0) ? Colors.black : MobileColor.grayButtonColor
                      )
                  )
              ),
            ),
            (page > 1 && page == totalPage - 1) ? Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: 30,
              height: 30,
              decoration: MobileButton.buttonPage.copyWith(
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    page = page - 2;
                    setupPage(page);
                  },
                  style: MobileButton.buttonPageStyle,
                  child: Text((page - 1).toString(),
                      style: TextStyleMobile.button_14
                  )
              ),
            ) : const SizedBox(),
            (page > 0) ? Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: 30,
              height: 30,
              decoration: MobileButton.buttonPage.copyWith(
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    page--;
                    setupPage(page);
                  },
                  style: MobileButton.buttonPageStyle,
                  child: Text(page.toString(),
                      style: TextStyleMobile.button_14
                  )
              ),
            ) : const SizedBox(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: MobileColor.orangeColor
              ),
              child: TextButton(
                  onPressed: () {},
                  style: MobileButton.buttonPageStyle,
                  child: Text((page + 1).toString(),
                      style: TextStyleMobile.button_14.copyWith(
                          color: Colors.white
                      )
                  )
              ),
            ),
            (page + 1 < totalPage) ? Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    page++;
                    setupPage(page);
                  },
                  style: MobileButton.buttonPageStyle,
                  child: Text((page + 2).toString(),
                      style: TextStyleMobile.button_14
                  )
              ),
            ) : const SizedBox(),
            (page + 2 < totalPage && page == 0) ? Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    page = page + 2;
                    setupPage(page);
                  },
                  style: MobileButton.buttonPageStyle,
                  child: Text((page + 3).toString(),
                      style: TextStyleMobile.button_14
                  )
              ),
            ) : const SizedBox(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: (page + 1 < totalPage) ? Colors.white : Colors.grey
              ),
              child: TextButton(
                  onPressed: (page + 1 < totalPage) ? () {
                    page++;
                    setupPage(page);
                  } : null,
                  style: MobileButton.buttonPageStyle,
                  child: Text(">",
                      style: TextStyleMobile.button_14.copyWith(
                          color: (page + 1 < totalPage) ? Colors.black : MobileColor.grayButtonColor
                      )
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: spaceBetween),
              width: sizePageButton,
              height: sizePageButton,
              decoration: MobileButton.buttonPage.copyWith(
                  color: (page + 1 < totalPage) ? Colors.white : Colors.grey
              ),
              child: TextButton(
                  onPressed: (page + 1 < totalPage) ? () {
                    page = totalPage - 1;
                    setupPage(page);
                  } : null,
                  style: MobileButton.buttonPageStyle,
                  child: Text(">>",
                      style: TextStyleMobile.button_14.copyWith(
                          color: (page + 1 < totalPage) ? Colors.black : MobileColor.grayButtonColor
                      )
                  )
              ),
            ),
          ],
        ),
      );
  }
}