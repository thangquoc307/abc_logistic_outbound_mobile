import 'package:flutter/material.dart';
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
            title: Image.asset('assets/images/logo1.png'),
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
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/display");
                },
                child: Text("Outbound"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

