import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => context.pop(),
            child: SvgPicture.asset(AppAssets.backArrowIcon, width: 40, height: 40),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Text('Welcome back! Glad to see you, Again!', style: AppTextStyle.getHeadline1()),
              const Gap(30),
              NameTextFormField(
                hintText: 'Enter your E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(15),
              NameTextFormField(
                hintText: 'Enter your Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(icon: SvgPicture.asset(AppAssets.eyeIcon), onPressed: () {}),
              ),
              const Gap(30),
              MainButton(
                title: 'Login',
                onPressed: () {
                  // Handle login action
                },
              ),
              const Gap(30),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Gap(10),
                  Text(
                    'Or Login with',
                    style: AppTextStyle.getSmallText(color: AppColors.greyColor),
                  ),
                  Gap(10),
                  Expanded(child: Divider()),
                ],
              ),
              const Gap(20),
              SocialLoginRow(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        title: 'Don\'t have an account?',
        buttonText: 'Register Now',
        onPressed: () => context.navigateToReplacement(AppRouters.register),
      ),
    );
  }
}
