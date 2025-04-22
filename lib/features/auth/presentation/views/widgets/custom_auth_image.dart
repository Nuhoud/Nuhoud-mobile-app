import 'package:flutter/material.dart';

class CustomAuthImage extends StatelessWidget {
  const CustomAuthImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).height * 0.8,
    );
  }
}
