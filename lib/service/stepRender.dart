import 'package:flutter/material.dart';
import '../cascadeStyle/color.dart';
import '../cascadeStyle/fonts.dart';

class StepRenderCustom {
  static const double _thicknessLine = 2.5;
  static const double _iconSize = 35;
  static SingleChildScrollView stepRender(List<String> titles, int step, BuildContext context) {
    var list = <Widget>[];
    for (int i = 0; i < titles.length; i++){
      String title = titles[i];
      Color colorMain;
      TextStyle textStyleTitle;
      TextStyle textStyleNumber;

      if (step >= i) {
        colorMain = MobileColor.orangeColor;
        textStyleNumber = TextStyleMobile.body_14.copyWith(color: Colors.white);
        textStyleTitle = TextStyleMobile.body_14.copyWith(color: colorMain);
      } else {
        colorMain = Colors.grey;
        textStyleNumber = TextStyleMobile.body_14.copyWith(color: Colors.white);
        textStyleTitle = TextStyleMobile.body_14.copyWith(color: colorMain);
      }

      list.add(
        Expanded(
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: _thicknessLine,
                          color: colorMain
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorMain,
                          borderRadius: BorderRadius.circular(_iconSize)
                      ),
                      width: _iconSize,
                      height: _iconSize,
                      child: Text((i + 1).toString(),
                          style: textStyleNumber),
                    ),
                    Expanded(
                      child: Container(
                          height: _thicknessLine,
                          color: colorMain
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                        child: Text(title,
                          style: textStyleTitle,
                          textAlign: TextAlign.center,)
                    )
                  ],
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ),
      );
    }

    final double popupWidth = MediaQuery.of(context).size.width * 0.8;
    final double stepWidth = popupWidth / 2 * titles.length;
    final double stepItemWidth = stepWidth / titles.length;
    final double initialOffset = (step < 2) ? 0 : stepItemWidth * (step - 1);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(initialScrollOffset: initialOffset),
      child: SizedBox(
        width: stepWidth,
        child: Row(
            children: list
        ),
      ),
    );
  }
}