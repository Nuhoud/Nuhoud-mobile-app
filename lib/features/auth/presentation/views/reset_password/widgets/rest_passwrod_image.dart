import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_data.dart';

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, top: 15),
          height: MediaQuery.sizeOf(context).height * 0.18,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              AssetsData.forgetPassword,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }
}
