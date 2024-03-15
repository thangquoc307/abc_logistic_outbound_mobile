import 'package:flutter/material.dart';
import 'package:flutter_outbound/components/beginRouter.dart';
import 'package:flutter_outbound/components/createOutboundOrder.dart';
import 'package:flutter_outbound/components/outboundDisplay.dart';
import 'package:flutter_outbound/components/relabelFeature.dart';
import 'package:flutter_outbound/components/test/testScanner.dart';
import 'package:flutter_outbound/state/bluetoothPrinter.dart';
import 'package:flutter_outbound/state/globalState.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/test/testPrinter.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GlobalState()),
          ChangeNotifierProvider(create: (context) => BluetoothPrinter()), // Thêm dòng này để thêm class quản lý state mới
        ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.inter().fontFamily,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const BeginRouter(),
          '/display': (context) => const OutboundDisplay(),
          '/create': (context) => const CreateOutboundOrder(),
          '/relabel': (context) => const RelabelFeature(),
          '/test': (context) => const TestScanner(),
        },
      ),
    ),
  );
}





