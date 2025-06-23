import 'dart:developer';

import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dailog.dart';
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
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showLoadingDialog(context);
          } else if (state is AuthAuthenticated) {
            Navigator.pop(context);
            log('${context.read<AuthCubit>().emailController}');
            showSuccessSnackbar(context, 'Password reset link sent!');
            context.navigateTo(
              AppRouters.otpVerification,
              arguments: context.read<AuthCubit>().emailController.text,
            );
          } else if (state is AuthUnauthenticated) {
            Navigator.pop(context);
            showErrorSnackbar(context, 'Failed to send password reset link.');
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
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!isEmailValid(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const Gap(30),
                      MainButton(
                        title: 'Send Code',
                        onPressed: () {
                          // Handle login action
                          if (cubit.formKey.currentState?.validate() ?? false) {
                            cubit.forgetPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              title: 'Remember Password?',
              buttonText: 'Login',
              onPressed: () => context.navigateToReplacement(AppRouters.login),
            ),
          );
        },
      ),
    );
  }
}
