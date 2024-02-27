import 'package:flutter/material.dart';
import 'package:flutter_outbound/components/createOutboundOrder.dart';
import 'package:flutter_outbound/components/mainpage.dart';
import 'package:flutter_outbound/model/globalState.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
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
          '/': (context) => const MainPage(),
          '/create': (context) => const CreateOutboundOrder(),
        },
      ),
    ),
  );
}





