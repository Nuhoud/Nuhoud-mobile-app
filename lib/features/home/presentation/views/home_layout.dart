import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/features/home/presentation/views/home_page.dart';
import 'package:nuhoud/features/user_plan/presentation/views/user_plan_page.dart';

import '../../../../core/utils/size_app.dart';
import '../../../profile/presentation/views/proflie_page.dart';

class HomeLayout extends StatefulWidget {
  final bool isViewBook;
  const HomeLayout({super.key, this.isViewBook = false});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final PageController _pageController;
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    UserPlanPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.isViewBook ? 1 : 0;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final icons = [
      [AssetsData.searchFillNav, AssetsData.searchNav],
      [AssetsData.roadMapNav, AssetsData.roadMapFillNav],
      [AssetsData.profileFillNav, AssetsData.profileNav],
    ];

    final titles = ['الرئيسية', 'الخطة', 'الملف الشخصي'];

    return Material(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Container(
        height: response(context, 90),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(blurRadius: 12, color: Colors.black.withValues(alpha: .12), offset: const Offset(0, -4))
          ],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => _buildNavItem(index, titles[index], icons[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String title, List<String> icons) {
    final bool selected = index == currentIndex;

    return GestureDetector(
      onTap: () => _onNavBarTapped(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: response(context, 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: response(context, 28),
              height: response(context, 28),
              child: SvgPicture.asset(
                selected ? icons[0] : icons[1],
                colorFilter: ColorFilter.mode(
                    selected ? AppColors.textWhite : AppColors.textWhite.withValues(alpha: 0.6), BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
