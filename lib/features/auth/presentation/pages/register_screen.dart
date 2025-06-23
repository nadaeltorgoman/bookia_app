import 'dart:developer';

import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dailog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            log('--------->Registration in progress');
            showLoadingDialog(context);
          } else if (state is AuthAuthenticated) {
            log('--------->Registration successful');
            Navigator.pop(context);
            showSuccessSnackbar(context, 'Registration successful!');
            context.navigateToReplacement(AppRouters.login);
          } else if (state is AuthUnauthenticated) {
            log('--------->Registration failed');
            Navigator.pop(context);
            showErrorSnackbar(context, 'Registration failed');
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
                      Text('Hello! Register to get started', style: AppTextStyle.getHeadline1()),
                      const Gap(30),
                      NameTextFormField(
                        controller: cubit.usernameController,
                        hintText: 'Username',
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      NameTextFormField(
                        controller: cubit.emailController,
                        hintText: 'Enter your E-mail',
                        keyboardType: TextInputType.emailAddress,
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
                        controller: cubit.passwordController,
                        hintText: 'Password',
                        obscureText: cubit.isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon:
                              cubit.isPasswordVisible
                                  ? SvgPicture.asset(AppAssets.eyeIcon)
                                  : Icon(Icons.visibility_off),
                          onPressed: () {
                            // Toggle password visibility
                            cubit.togglePasswordVisibility();
                          },
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (isPasswordValid(value)) {
                            return 'Password must be at least 8 characters long, contain uppercase and lowercase letters, numbers, and special characters';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      NameTextFormField(
                        controller: cubit.confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: cubit.isConfirmPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon:
                              cubit.isConfirmPasswordVisible
                                  ? SvgPicture.asset(AppAssets.eyeIcon)
                                  : Icon(Icons.visibility_off),
                          onPressed: () {
                            // Toggle confirm password visibility
                            cubit.toggleConfirmPasswordVisibility();
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (!isConfirmPasswordValid(
                            cubit.passwordController.text,
                            value,
                          )) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const Gap(30),
                      MainButton(
                        title: 'Register',
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.register();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              title: 'Already have an account?',
              buttonText: 'Login Now',
              onPressed: () => context.navigateToReplacement(AppRouters.login),
            ),
          );
        },
      ),
    );
  }
}
