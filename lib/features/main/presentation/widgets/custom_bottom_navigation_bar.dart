import 'dart:developer';
import 'dart:math' hide log;
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required NotchBottomBarController controller,
    required PageController pageController,
  }) : _controller = controller,
       _pageController = pageController;

  final NotchBottomBarController _controller;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedNotchBottomBar(
      notchBottomBarController: _controller,
      kIconSize: 24.0,
      color: AppColors.whiteColor,
      maxLine: 1,
      kBottomRadius: 2.0,
      removeMargins: false,
      bottomBarWidth: 500,
      bottomBarHeight: 60.0,
      showBottomRadius: false,
      showShadow: true,
      shadowElevation: 2.0,
      durationInMilliSeconds: 300,

      notchShader: SweepGradient(
        startAngle: 0,
        endAngle: pi / 2,
        colors: [AppColors.primaryColor, AppColors.primaryColor],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),

      bottomBarItems: [
        customBottomBarItem(AppAssets.homeIcon),
        customBottomBarItem(AppAssets.bookmarkIcon),
        customBottomBarItem(AppAssets.categoryIcon),
        customBottomBarItem(AppAssets.profileIcon),
      ],
      onTap: (index) {
        log('current selected index $index');
        _pageController.jumpToPage(index);
      },
    );
  }

  BottomBarItem customBottomBarItem(String svgIcon) {
    return BottomBarItem(
      inActiveItem: SvgPicture.asset(
        svgIcon,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      activeItem: SvgPicture.asset(
        svgIcon,
        colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
      ),
    );
  }
}
