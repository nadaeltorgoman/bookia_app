import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AppLeadingButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Text('Hello! Register to get started', style: AppTextStyle.getHeadline1()),
              const Gap(30),
              NameTextFormField(hintText: 'Username', keyboardType: TextInputType.name),
              const Gap(15),
              NameTextFormField(
                hintText: 'Enter your E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(15),
              NameTextFormField(
                hintText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(icon: SvgPicture.asset(AppAssets.eyeIcon), onPressed: () {}),
              ),
              const Gap(15),
              NameTextFormField(
                hintText: 'Confirm Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(icon: SvgPicture.asset(AppAssets.eyeIcon), onPressed: () {}),
              ),
              const Gap(30),
              MainButton(
                title: 'Register',
                onPressed: () {
                  // Handle login action
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        title: 'Already have an account?',
        buttonText: 'Login Now',
        onPressed: () => context.navigateToReplacement(AppRouters.login),
      ),
    );
  }
}
