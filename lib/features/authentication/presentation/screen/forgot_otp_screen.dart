

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/verify_otp_provider.dart';

class ForgotOtpVerificationCodeScreen extends ConsumerStatefulWidget {
  const ForgotOtpVerificationCodeScreen({super.key});

  @override
  ConsumerState<ForgotOtpVerificationCodeScreen> createState() =>
      _VerificationCodeScreenState();
}

class _VerificationCodeScreenState
    extends ConsumerState<ForgotOtpVerificationCodeScreen> {
  String? email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    email ??= GoRouterState.of(context).extra as String?;
    if (email != null) {

    }
  }



  @override
  Widget build(BuildContext context) {
    final otpNotifier = ref.read(verifyOtpProvider.notifier);
    final otpState = ref.watch(verifyOtpProvider);

    // Dark-themed pin box (empty / default)
    final emptyPinTheme = PinTheme(
      width: 65.w,
      height: 65.h,
      textStyle: GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF1F2937),
          width: 1.5,
        ),
      ),
    );

    // Focused pin box — slightly lighter with green border
    final focusedPinTheme = emptyPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.primary,
          width: 2,
        ),
      ),
    );

    // Submitted (filled) pin box
    final submittedPinTheme = emptyPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFF1A2E24),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.primary,
          width: 1.5,
        ),
      ),
    );

    // Error pin box
    final errorPinTheme = emptyPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.error,
          width: 1.5,
        ),
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.9, -1.0),
            radius: 1.3,
            colors: [
              Color(0xFF1E5F46),
              Color(0xFF0B1F1A),
              Color(0xFF0E1115),
              Color(0xFF030712),
            ],
            stops: [0.0, 0.35, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Back Button
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Logo
              Center(
                child: Image.asset(
                  IconPath.appLogo,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 24.h),

              // Title — centered
              Center(
                child: Text(
                  "Código de verificación",
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Subtitle — centered
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Hemos enviado un código de cuatro dígitos a tu dirección de correo electrónico",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9AA4AF),
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // OTP Input
              Center(
                child: Pinput(
                  length: 4,
                  controller: otpNotifier.otpController,
                  focusNode: otpNotifier.otpFocusNode,
                  defaultPinTheme: emptyPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  showCursor: true,
                  separatorBuilder: (index) => SizedBox(width: 12.w),
                  cursor: Container(
                    width: 2,
                    height: 28.h,
                    color: AppColor.primary,
                  ),
                  onCompleted: (pin) {},
                  onChanged: (value) {
                    otpNotifier.updateOtp(value);
                    if (otpState.errorMessage != null) {
                      otpNotifier.clearError();
                    }
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  forceErrorState: otpState.errorMessage != null,
                ),
              ),

              // Error Message
              if (otpState.errorMessage != null) ...[
                SizedBox(height: 16.h),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColor.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            color: AppColor.error, size: 18.sp),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: CustomText(
                            text: otpState.errorMessage!,
                            color: AppColor.error,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 40.h),

              // Enviar Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomButton(
                  suffixIcon: Icons.arrow_forward,
                  text: otpState.isLoading ? "Verificando..." : "Enviar",
                  onPressed: otpState.isLoading
                      ? null
                      : () {
                    if (otpNotifier.otpController.text.length != 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Por favor ingresa el código completo de 4 dígitos'),
                          backgroundColor: AppColor.error,
                        ),
                      );
                      return;
                    }
                    context.push("/resetPassword");
                  },
                  backgroundGradient: const LinearGradient(
                    colors: [Color(0xFF4FAF84), Color(0xFF3D8E70)],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Resend Timer
              Center(
                child: otpState.canResend
                    ? GestureDetector(
                  onTap: otpState.isLoading
                      ? null
                      : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            '¡Código de verificación enviado!'),
                        backgroundColor: AppColor.primary,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    "Reenviar código",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reenviar código en ",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9AA4AF),
                      ),
                    ),
                    Text(
                      otpNotifier.formattedTimer,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Spam folder hint
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 15.sp,
                      color: const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        "¿No puedes encontrar el correo electrónico? Revisa tu carpeta de spam.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}