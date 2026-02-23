

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/utils/service/network_caller.dart';

class VerifyOtpState {
  final bool isLoading;
  final String? errorMessage;
  final String otp;
  final int resendTimer;
  final bool canResend;
  final String? accessToken;

  VerifyOtpState({
    this.isLoading = false,
    this.errorMessage,
    this.otp = '',
    this.resendTimer = 43,
    this.canResend = false,
    this.accessToken,
  });

  VerifyOtpState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? otp,
    int? resendTimer,
    bool? canResend,
    String? accessToken,
  }) {
    return VerifyOtpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      otp: otp ?? this.otp,
      resendTimer: resendTimer ?? this.resendTimer,
      canResend: canResend ?? this.canResend,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

class VerifyOtpProvider extends StateNotifier<VerifyOtpState> {
  VerifyOtpProvider() : super(VerifyOtpState()) {
    _startResendTimer();
  }

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  final NetworkCaller networkCaller = NetworkCaller();

  Timer? _resendTimer;

  void _startResendTimer() {
    _resendTimer?.cancel();
    state = state.copyWith(resendTimer: 43, canResend: false);

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer > 0) {
        state = state.copyWith(resendTimer: state.resendTimer - 1);
      } else {
        state = state.copyWith(canResend: true);
        timer.cancel();
      }
    });
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value, errorMessage: null);
  }

  /// verify otp
  /*Future<void> verifyOtp(String email, BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      var response = await networkCaller.postRequest(
        AppUrl.verifyOtp,
        body: {
          'email': email,
          'otp': otpController.text.trim(),
        },
      );

      if (response.isSuccess) {
        log("✅ OTP verified: ${response.responseData}");
        final accessToken = response.responseData['result']['accessToken'];

        log("✅ OTP verified, token: $accessToken");

        // ✅ SAVE TOKEN IMMEDIATELY TO SharedPreferences
        await AuthService.saveToken(accessToken);

        // ✅ Set userSetUp to false (user needs to complete setup)
        await AuthService.saveStatus(false);

        log("✅ Token saved to SharedPreferences");

        // Update state with token
        state = state.copyWith(
          isLoading: false,
          accessToken: accessToken,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.errorMessage ?? 'Verification failed',
        );
      }
    } catch (e) {
      log("❌ exception: ${e.toString()}");
      state = state.copyWith(
        isLoading: false,
        errorMessage: "An error occurred during verification",
      );
    }
  }*/

  /*Future<void> resendOtp(String email) async {
    if (!state.canResend) {
      state = state.copyWith(
        errorMessage: 'Please wait before resending code',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      var response = await networkCaller.postRequest(
        AppUrl.resendOtp,
        body: {'email': email},
      );

      if (response.isSuccess) {
        log("✅ OTP resent successfully");
        state = state.copyWith(isLoading: false);
        _startResendTimer();
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.errorMessage ?? 'Failed to resend code',
        );
      }
    } catch (e) {
      log("❌ Resend OTP exception: ${e.toString()}");
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to resend code. Please try again.',
      );
    }
  }*/

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String get formattedTimer {
    final minutes = state.resendTimer ~/ 60;
    final seconds = state.resendTimer % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }
}

final verifyOtpProvider =
StateNotifierProvider<VerifyOtpProvider, VerifyOtpState>(
      (ref) => VerifyOtpProvider(),
);