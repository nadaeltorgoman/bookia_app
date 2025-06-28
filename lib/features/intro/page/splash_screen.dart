import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    final token = SharedPref.getUserToken();
    if (token != null && token.isNotEmpty) {
      // Add debug print to verify token
      debugPrint('Token exists: $token');
      if (mounted) {
        context.navigateToReplacement(AppRouters.main);
      }
    } else {
      if (mounted) {
        context.navigateToReplacement(AppRouters.welcome);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logo, width: 210),
            const Gap(10),
            Text('Order Your Book Now!', style: AppTextStyle.getTitleText()),
          ],
        ),
      ),
    );
  }
}
