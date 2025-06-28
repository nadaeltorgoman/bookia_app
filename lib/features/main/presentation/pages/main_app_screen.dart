import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  @override
  void initState() {
    super.initState();
    _controller.index = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    log('MainAppScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomeScreen(),
      Center(
        child: Text(SharedPref.getUserInfo()?.email.toString() ?? 'Page 2'),
      ),
      Center(
        child: Text(SharedPref.getUserInfo()?.phone.toString() ?? 'Page 3'),
      ),
      Center(
        child: Text(SharedPref.getUserInfo()?.address.toString() ?? 'Page 4'),
      ),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.homeIcon,
              colorFilter: ColorFilter.mode(
                _controller.index == 0
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
            label: '', // <-- Add this
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.bookmarkIcon,
              colorFilter: ColorFilter.mode(
                _controller.index == 1
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
            label: '', // <-- Add this
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.categoryIcon,
              colorFilter: ColorFilter.mode(
                _controller.index == 2
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
            label: '', // <-- Add this
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.profileIcon,
              colorFilter: ColorFilter.mode(
                _controller.index == 3
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
            label: '', // <-- Add this
          ),
        ],
        currentIndex: _controller.index,
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
          setState(() {
            _controller.index = index;
          });
        },
      ),
    );
  }
}
