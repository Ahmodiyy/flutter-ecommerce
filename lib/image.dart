import 'package:flutter/material.dart';

class ImageBuild extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  const ImageBuild(
      {Key? key,
      this.width = double.infinity,
      required this.height,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
