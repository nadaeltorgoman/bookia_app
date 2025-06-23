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
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:bookia/features/auth/presentation/widgets/name_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, this.verifiedCode});
  final int? verifiedCode;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
            showSuccessSnackbar(context, 'Password reset successful!');
            context.navigateToReplacement(AppRouters.success);
          } else if (state is AuthUnauthenticated) {
            Navigator.pop(context);
            showErrorSnackbar(context, 'Failed to reset password. Please try again.');
            log('Failed to reset password: ${state.errorMessage}');
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Form(
            key: cubit.formKey,
            child: Scaffold(
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
                        obscureText: cubit.isPasswordVisible ? false : true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          if (isPasswordValid(value)) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        controller: cubit.newPasswordController,
                        suffixIcon: IconButton(
                          icon:
                              cubit.isPasswordVisible
                                  ? SvgPicture.asset(AppAssets.eyeIcon)
                                  : Icon(Icons.visibility_off),
                          onPressed: () {
                            cubit.togglePasswordVisibility();
                          },
                        ),
                      ),
                      const Gap(15),
                      NameTextFormField(
                        hintText: 'Confirm New Password',
                        obscureText: cubit.isConfirmPasswordVisible ? false : true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: cubit.confirmNewPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (!isConfirmPasswordValid(value, cubit.newPasswordController.text)) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon:
                              cubit.isConfirmPasswordVisible
                                  ? SvgPicture.asset(AppAssets.eyeIcon)
                                  : Icon(Icons.visibility_off),
                          onPressed: () {
                            cubit.toggleConfirmPasswordVisibility();
                          },
                        ),
                      ),
                      const Gap(30),
                      MainButton(
                        title: 'Reset Password',
                        onPressed: () {
                          // Handle login action
                          if (cubit.formKey.currentState?.validate() ?? false) {
                            log('----------> verifyCode: ${widget.verifiedCode}');
                            cubit.newPassword(widget.verifiedCode);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
