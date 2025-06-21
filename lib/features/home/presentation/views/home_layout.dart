import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/features/home/presentation/views/home_page.dart';

import '../../../../core/utils/size_app.dart';
import '../../../profile/presentation/views/proflie_page.dart';

class HomeLayout extends StatefulWidget {
  final bool isViewBook;
  const HomeLayout({super.key, this.isViewBook = false});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: AppColors.backgroundColor,
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(100),
          color: AppColors.backgroundColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: response(context, 75),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedLabelStyle: const TextStyle(fontSize: 0, height: 0),
                unselectedLabelStyle: const TextStyle(fontSize: 0, height: 0),
                items: [
                  _buildNavItem(
                    AssetsData.searchNav,
                    AssetsData.searchFillNav,
                    0,
                  ),
                  _buildNavItem(
                    AssetsData.roadMapFillNav,
                    AssetsData.roadMapNav,
                    1,
                  ),
                  _buildNavItem(
                    AssetsData.profileNav,
                    AssetsData.profileFillNav,
                    2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String asset,
    String assetSelected,
    int index,
  ) {
    final bool isSelected = currentIndex == index;
    const Color bgColor = AppColors.primaryColor;

    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        width: response(context, 80),
        height: response(context, 52),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: SizedBox(
            width: response(context, 26),
            height: response(context, 26),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(
                isSelected ? assetSelected : asset,
                color: isSelected ? null : AppColors.iconNavBarColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
