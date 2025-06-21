import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.successMark, width: 125, height: 125),
              const Gap(30),
              Text('Password Changed!', style: AppTextStyle.getHeadline1()),
              const Gap(15),
              Text(
                'Your password has been changed successfully.',
                textAlign: TextAlign.center,
                style: AppTextStyle.getBodyText(),
              ),
              const Gap(30),
              MainButton(
                title: 'Back to Login',
                onPressed: () {
                  // Handle login action
                  context.navigateToReplacement(AppRouters.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
