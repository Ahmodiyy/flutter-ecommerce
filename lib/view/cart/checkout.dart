import 'package:ecommerce/extensions.dart';
import 'package:flutter/material.dart';

import '../../image_build.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: constraints.isMobile
              ? const EdgeInsets.all(50.0)
              : const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
          child: const ImageBuild(
            imagePath: 'images/thanks.jpg',
            height: 200,
          ),
        );
      },
    );
  }
}
