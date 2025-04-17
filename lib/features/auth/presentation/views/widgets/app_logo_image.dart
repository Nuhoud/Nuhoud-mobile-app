import 'package:flutter/material.dart';

import '../../../../../core/utils/assets_data.dart';

class AppLogoImage extends StatelessWidget {
  const AppLogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsData.logo,
      width: MediaQuery.sizeOf(context).width * 0.4,
      height: MediaQuery.sizeOf(context).height * 0.4,
    );
  }
}
