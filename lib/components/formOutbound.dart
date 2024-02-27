import 'package:flutter/cupertino.dart';
import 'package:flutter_outbound/components/formStepper/outboundStep02.dart';
import 'package:flutter_outbound/components/formStepper/outboundStep03.dart';
import 'package:flutter_outbound/components/formStepper/outboundStep04.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:provider/provider.dart';

import 'formStepper/outboundStep01.dart';

class FormOutbound extends StatelessWidget {
  const FormOutbound({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        switch (state.currentStep) {
          case 0 :
            return const Step01();
          case 1 :
            return const Step02();
          case 2 :
            return const Step03();
          case 3 :
            return const Step04();
          case 4 :
            return Text("5");
          default:
            return const Text("Error Router");
        }
      },
    );
  }
}
