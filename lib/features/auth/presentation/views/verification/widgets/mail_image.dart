import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_data.dart';

class MailImage extends StatelessWidget {
  const MailImage({
    super.key,
  });

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
              AssetsData.mail,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }
}
