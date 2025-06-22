import 'dart:developer';

import 'package:bookia/features/auth/data/model/request/register_params.dart';
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
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterParams params = RegisterParams();

  bool _isPasswordVisible = true;
  bool _confirmPasswordController = true;

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
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } on Exception catch (_) {
      emit(AuthUnauthenticated());
    }
  }
}
