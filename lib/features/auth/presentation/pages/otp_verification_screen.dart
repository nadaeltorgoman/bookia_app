import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/auth/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
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
              Text('OTP Verification', style: AppTextStyle.getHeadline1()),
              const Gap(15),
              Text(
                'Enter the verification code we just sent on your email address.',
                style: AppTextStyle.getBodyText(),
              ),
              const Gap(30),
              Center(
                child: Pinput(
                  length: 4,
                  onCompleted: (pin) {
                    // Handle OTP submission
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
                  context.navigateTo(AppRouters.newPassword);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        title: 'Didn\'t received code?',
        buttonText: 'Resend Code',
        onPressed:
            () => context.navigateToReplacement(AppRouters.otpVerification),
      ),
    );
  }
}
