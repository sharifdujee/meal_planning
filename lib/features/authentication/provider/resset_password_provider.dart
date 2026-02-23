

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/service/network_caller.dart';

class ResetPasswordState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final String? errorMessage;
  final bool canResend; // added for resend button

  ResetPasswordState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.canResend = true,
  });

  ResetPasswordState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    bool? canResend,
  }) {
    return ResetPasswordState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      canResend: canResend ?? this.canResend,
    );
  }
}

class ResetPasswordProvider extends StateNotifier<ResetPasswordState> {
  ResetPasswordProvider() : super(ResetPasswordState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();
  String? _accessToken;

  String? get accessToken => _accessToken;

  final NetworkCaller networkCaller = NetworkCaller();

  /// OTP Focus Node
  final otpFocusNode = FocusNode();

  /// Timer for resend OTP
  Timer? _timer;
  int _secondsRemaining = 60;

  String get formattedTimer {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  /// Update OTP while typing
  void updateOtp(String value) {
    otpController.text = value;
  }

  /// Send OTP
 /* Future<void> sendOtp() async {
    state = state.copyWith(isLoading: true);
    try {
      var response = await networkCaller.postRequest(AppUrl.sendOtp, body: {
        'email': emailController.text.trim(),
      });

      if (response.isSuccess) {
        log("Send OTP response: ${response.responseData}");
        startResendTimer();
      }
    } catch (e) {
      log("Send OTP error: $e");
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }*/

  /// Verify OTP
  /*Future<void> otpVerification(BuildContext context, String email) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await networkCaller.postRequest(
        AppUrl.otpVerification,
        body: {
          'email': email,
          'otp': otpController.text.trim(),
        },
      );

      if (response.isSuccess) {
        final token = response.responseData['result']['accessToken'];

        _accessToken = token; // ✅ store token

        log("Access Token: $token");

        // ✅ Navigate & pass token
        context.go(
          "/resetPasswordScreen",
          extra: token,
        );
      } else {
        state = state.copyWith(errorMessage: response.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }*/


  /// update password
  /*Future<void> resetPassword(BuildContext context, String token) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await networkCaller.patchRequest(
        AppUrl.resetPassword,
        body: {
          'newPassword': passwordController.text.trim(),
        },
        token: token, // ✅ token used here
      );

      if (response.isSuccess) {
        log("Password reset success: ${response.responseData}");
        context.push('/login');

      } else {
        state = state.copyWith(errorMessage: response.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }*/


  /// Resend OTP
  void resendOtp() {
    if (state.canResend) {
      //sendOtp();
    }
  }

  /// Timer for Resend OTP cooldown
  void startResendTimer() {
    state = state.copyWith(canResend: false);
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        state = state.copyWith(canResend: true);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    otpFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

final resetPasswordProvider =
StateNotifierProvider<ResetPasswordProvider, ResetPasswordState>(
      (ref) => ResetPasswordProvider(),
);