import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/color.dart';
import 'package:flutter_outbound/cascadeStyle/fonts.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:provider/provider.dart';

class StepperCustom extends StatelessWidget {
  static const double _thicknessLine = 2.5;
  static const double _iconSize = 35;
  static const List<String> titles = [
    "Open", "Start Picking", "Start Packing", "Start Shipping", "Completed"
  ];

  const StepperCustom({
    super.key,
  });

  List<Widget> _stepRender(GlobalState state) {
    var list = <Widget>[];
    for (int i = 0; i < titles.length; i++){
      String title = titles[i];
      Color colorMain;
      TextStyle textStyleTitle;
      TextStyle textStyleNumber;

      if (state.currentStep == i) {
        colorMain = MobileColor.greenButtonColor;
        textStyleNumber = TextStyleMobile.body_14.copyWith(color: Colors.white);
        textStyleTitle = TextStyleMobile.body_14.copyWith(color: colorMain);
      } else if (state.finishStep >= i) {
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
            child: InkWell(
              onTap: () {
                state.currentStep = i;
              },
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
          )
      );
    }
    return list ;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GlobalState>(context, listen: true);
    final double stepWidth = MediaQuery.of(context).size.width / 3 * 5;
    final double stepItemWidth = stepWidth / titles.length;
    final double initialOffset = (state.currentStep < 3) ? 0 : stepItemWidth * (state.currentStep - 2);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(initialScrollOffset: initialOffset),
      child: SizedBox(
        width: stepWidth,
        child: Row(
            children: _stepRender(state)
        ),
      ),
    );
  }
}
