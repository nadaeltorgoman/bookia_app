import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AppLeadingButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forget Password?', style: AppTextStyle.getHeadline1()),
              const Gap(15),
              Text(
                'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                style: AppTextStyle.getBodyText(),
              ),
              const Gap(30),
              NameTextFormField(
                hintText: 'Enter your E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(30),
              MainButton(
                title: 'Send Code',
                onPressed: () {
                  // Handle login action
                  context.navigateTo(AppRouters.otpVerification);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        title: 'Remember Password?',
        buttonText: 'Login',
        onPressed: () => context.navigateToReplacement(AppRouters.login),
      ),
    );
  }
}
