


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/utils/service/network_caller.dart';

class LoginState {
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;

  LoginState({
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.passwordError,
    this.isFormValid = false,
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? passwordError,
    bool? isFormValid,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

class LoginProvider extends StateNotifier<LoginState> {
  final Ref ref;

  LoginProvider(this.ref) : super(LoginState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final NetworkCaller networkCaller = NetworkCaller();

  void init() {
    // Add listeners to controllers
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

    final isValid = emailError == null &&
        passwordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty;

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: isValid,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Must contain at least one special character';
    }

    return null;
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }



  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  @override
  void dispose() {
    emailController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>(
      (ref) => LoginProvider(ref),
);


///