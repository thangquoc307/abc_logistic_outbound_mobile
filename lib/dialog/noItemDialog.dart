import 'package:flutter/material.dart';
import 'package:flutter_outbound/cascadeStyle/image.dart';

import '../cascadeStyle/fonts.dart';

class NoItemDialog extends StatelessWidget {
  const NoItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Image(image: AssetsImage.notFound),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyleMobile.h1_14
              .copyWith(color: Colors.grey)),
        ),
      ],
    );
  }
}
