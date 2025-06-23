import 'dart:developer';

import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dailog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            log('--------->Login in progress');
            showLoadingDialog(context);
          } else if (state is AuthAuthenticated) {
            //context.navigateToNamedReplacement(AppRouters.home);
            log('--------->Login successful');
            Navigator.pop(context);
            showSuccessSnackbar(context, 'Login successful!');
          } else if (state is AuthUnauthenticated) {
            log('--------->Login failed');
            Navigator.pop(context);
            showErrorSnackbar(context, 'Login failed. Please try again.');
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Scaffold(
            appBar: AppBar(leading: AppLeadingButton()),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Welcome back! Glad to see you, Again!',
                        style: AppTextStyle.getHeadline1(),
                      ),
                      const Gap(30),
                      NameTextFormField(
                        hintText: 'Enter your E-mail',
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!isEmailValid(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      NameTextFormField(
                        hintText: 'Enter your Password',
                        obscureText: cubit.isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon:
                              cubit.isPasswordVisible
                                  ? SvgPicture.asset(AppAssets.eyeIcon)
                                  : Icon(Icons.visibility_off),
                          onPressed: () {
                            cubit.togglePasswordVisibility();
                          },
                        ),
                        controller: cubit.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.navigateTo(AppRouters.forgetPassword),
                          child: Text(
                            'Forget Password?',
                            style: AppTextStyle.getSmallText(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      const Gap(15),
                      MainButton(
                        title: 'Login',
                        onPressed: () {
                          // Handle login action
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.login();
                          }
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
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              title: 'Don\'t have an account?',
              buttonText: 'Register Now',
              onPressed: () => context.navigateTo(AppRouters.register),
            ),
          );
        },
      ),
    );
  }
}
