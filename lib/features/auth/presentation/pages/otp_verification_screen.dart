import 'dart:developer';

import 'package:bookia/components/dialogs/loading_dailog.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, this.email});
  final String? email;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
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
            showSuccessSnackbar(context, 'OTP verification successful!');
            context.navigateToReplacement(
              AppRouters.newPassword,
              arguments: int.tryParse(context.read<AuthCubit>().otpController.text),
            );
          } else if (state is AuthUnauthenticated) {
            Navigator.pop(context);
            showErrorSnackbar(context, 'OTP verification failed. Please try again.');
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
                      Text('OTP Verification', style: AppTextStyle.getHeadline1()),
                      const Gap(15),
                      Text(
                        'Enter the verification code we just sent on your email address.',
                        style: AppTextStyle.getBodyText(),
                      ),
                      const Gap(30),
                      Center(
                        child: Pinput(
                          length: 6,
                          autofocus: true,
                          controller: cubit.otpController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            } else if (!isNumeric(value) || value.length != 6) {
                              return 'Please enter a valid 6-digit OTP';
                            }
                            return null;
                          },
                          onCompleted: (value) {
                            log('OTP entered: $value');
                            cubit.params.verifyCode = int.tryParse(value.trim());
                            log('OTP verification request body: ${cubit.params.toJson()}');
                          },
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: AppTextStyle.getHeadline2(color: Colors.black),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: AppTextStyle.getHeadline2(color: Colors.black),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: AppTextStyle.getHeadline2(color: Colors.black),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const Gap(30),
                      MainButton(
                        title: 'Verify',
                        onPressed: () {
                          // Handle login action
                          if (cubit.formKey.currentState?.validate() ?? false) {
                            log('OTP verification request body: ${cubit.params.toJson()}');
                            cubit.otpVerification(widget.email);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              title: 'Didn\'t received code?',
              buttonText: 'Resend Code',
              onPressed: () => context.navigateToReplacement(AppRouters.forgetPassword),
            ),
          );
        },
      ),
    );
  }
}
