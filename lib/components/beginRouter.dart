import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/image.dart';
import '../cascadeStyle/color.dart';

class BeginRouter extends StatelessWidget {
  const BeginRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: MobileColor.orangeColor,
            title: const Image(image: AssetsImage.logoImage),
            actions: const [
              Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: 20,)
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/display");
                    },
                    child: const Text("Test Outbound"),
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/relabel");
                    },
                    child: const Text("Test Relabel"),
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/test");
                    },
                    child: const Text("Test Printer"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

