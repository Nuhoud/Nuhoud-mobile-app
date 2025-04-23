import 'package:flutter/material.dart';

class OnBordingImage extends StatelessWidget {
  const OnBordingImage({
    super.key,
    required this.image,
  });

  final String image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      margin: EdgeInsets.only(
        bottom: size.height * 0.02,
        top: size.height * 0.03,
      ),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }
}
