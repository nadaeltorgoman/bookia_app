import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AppLeadingButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Text('Forget Password?', style: AppTextStyle.getHeadline1()),
              const Gap(15),
              Text(
                'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                style: AppTextStyle.getBodyText(),
              ),
              const Gap(30),
              NameTextFormField(
                hintText: 'Enter your New Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppAssets.eyeIcon),
                  onPressed: () {},
                ),
              ),
              const Gap(15),
              NameTextFormField(
                hintText: 'Confirm New Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppAssets.eyeIcon),
                  onPressed: () {},
                ),
              ),
              const Gap(30),
              MainButton(
                title: 'Reset Password',
                onPressed: () {
                  // Handle login action
                  context.navigateToReplacement(AppRouters.success);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
