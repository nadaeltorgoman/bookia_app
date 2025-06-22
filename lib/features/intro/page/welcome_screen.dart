import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.backgroundImage, fit: BoxFit.cover),
          ),
          Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const Spacer(flex: 1),
                  Gap(context.screenHeight * 0.15),
                  SvgPicture.asset(
                    AppAssets.logo,
                    width: context.screenWidth * 0.6,
                  ),
                  Text(
                    'Order Your Book Now!',
                    style: AppTextStyle.getTitleText(),
                  ),
                  const Spacer(),
                  //Gap(context.screenHeight * 0.5),
                  MainButton(
                    title: 'Login',
                    onPressed: () {
                      context.navigateTo(AppRouters.login);
                    },
                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                  ),
                  Gap(context.screenHeight * 0.02),
                  MainButton(
                    title: 'Register',
                    onPressed: () {
                      context.navigateTo(AppRouters.register);
                    },
                    bgColor: AppColors.whiteColor,
                    textColor: AppColors.darkColor,
                    borderColor: AppColors.darkColor,
                  ),
                  // const Spacer(flex: 1),
                  Gap(context.screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
