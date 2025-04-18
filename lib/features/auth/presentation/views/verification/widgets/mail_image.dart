import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/enums.dart';

import '../../../../../../core/utils/assets_data.dart';

class VerificationImage extends StatelessWidget {
  const VerificationImage({
    super.key,
    required this.authType,
  });
  final AuthType authType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              authType == AuthType.email
                  ? AssetsData.mail
                  : AssetsData.verification,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }
}
