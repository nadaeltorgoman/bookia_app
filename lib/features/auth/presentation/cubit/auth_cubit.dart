import 'dart:developer';

import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/features/auth/data/model/request/register_params.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  RegisterParams params = RegisterParams();

  bool _isPasswordVisible = true;
  bool _confirmPasswordController = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _confirmPasswordController;

  // Add this method to toggle visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(AuthState());
  }

  void toggleConfirmPasswordVisibility() {
    _confirmPasswordController = !_confirmPasswordController;
    emit(AuthState());
  }

  register() {
    emit(AuthLoading());
    params.name = usernameController.text.trim();
    params.email = emailController.text.trim();
    params.password = passwordController.text.trim();
    params.passwordConfirmation = confirmPasswordController.text.trim();
    log('Register request body: ${params.toJson()}');
    try {
      AuthRepo.register(params).then((userResponse) {
        if (userResponse != null) {
          // add shared preferences
          SharedPref.setUserInfo(userResponse.data?.user ?? User());
          SharedPref.setUserToken(userResponse.data?.token ?? '');
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } on Exception catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  login() {
    emit(AuthLoading());
    params.email = emailController.text.trim();
    params.password = passwordController.text.trim();
    debugPrint('Login request body: ${params.toJson()}');

    AuthRepo.login(params)
        .then((userResponse) {
          if (userResponse != null && userResponse.data?.token != null) {
            debugPrint('Login successful, token: ${userResponse.data?.token}');
            SharedPref.setUserInfo(userResponse.data?.user ?? User());
            SharedPref.setUserToken(userResponse.data?.token ?? '');
            emit(AuthAuthenticated());
          } else {
            debugPrint('Login failed - null response or no token');
            emit(AuthUnauthenticated());
          }
        })
        .catchError((error) {
          debugPrint('Login error: $error');
          emit(AuthUnauthenticated(errorMessage: error.toString()));
        });
  }

  forgetPassword() {
    emit(AuthLoading());
    params.email = emailController.text.trim();
    log('Forget Password request body: ${params.toJson()}');
    try {
      AuthRepo.forgetPassword(params).then((userResponse) {
        if (userResponse != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } on Exception catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  otpVerification(String? email) {
    emit(AuthLoading());
    params.email = email;
    params.verifyCode = int.tryParse(
      otpController.text.trim(),
    ); // Parse OTP to int
    log('OTP Verification request body: ${params.toJson()}');
    try {
      AuthRepo.otpVerification(params).then((userResponse) {
        if (userResponse != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } on Exception catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  newPassword(int? verifiedCode) {
    emit(AuthLoading());
    params.verifyCode = verifiedCode;
    params.newPassword = newPasswordController.text.trim();
    params.confirmNewPassword = confirmNewPasswordController.text.trim();
    log('New Password request body: ${params.toJson()}');
    try {
      AuthRepo.newPassword(params).then((userResponse) {
        if (userResponse != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } on Exception catch (e) {
      emit(AuthUnauthenticated(errorMessage: e.toString()));
    }
  }
}
