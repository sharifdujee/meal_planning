import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/global/custom_text_form_field.dart';
import 'package:meal_planning/features/authentication/provider/login_provider.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),

                  /// Logo
                  Image.asset(
                    IconPath.appLogo,
                    width: 140.w,
                    height: 140.w,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 30.h),

                  /// Title
                  Text(
                    "Iniciar sesión",
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// Subtitle
                  Text(
                    "Bienvenido de nuevo",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9AA4AF),
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Email Label
                      CustomText(
                        text: "Dirección de correo electrónico",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                      SizedBox(height: 10.h),

                      /// Email Field
                      CustomTextFormField(
                        controller: loginNotifier.emailController,
                        hintText: "Dirección de correo electrónico",
                        hintTextColor: const Color(0xFF5B616E),
                        containerColor: const Color(0xFF111827),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF1F2937)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF1F2937)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF38755A)),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      /// Password Label
                      CustomText(
                        text: "Contraseña",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColor.white,
                      ),

                      SizedBox(height: 10.h),

                      /// Password Field
                      CustomTextFormField(
                        controller: loginNotifier.passwordController,
                        hintText: "••••••",
                        obscureText: !loginState.isPasswordVisible,
                        containerColor: const Color(0xFF111827),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF1F2937)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF1F2937)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF38755A)),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => loginNotifier.togglePasswordVisibility(),
                          child: Icon(
                            loginState.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF6B7280),
                            size: 20.sp,
                          ),
                        ),
                      ),

                      /// Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: GestureDetector(
                            onTap: (){
                              context.push("/forgotPassword");
                            },
                            child: CustomText(
                              text: "¿Olvidaste tu contraseña?",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: const Color(0xFF38755A),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      /// Divider with text — FIXED
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: const Color(0xFF6BC799),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: CustomText(
                              text: "O inicia sesión con",
                              fontSize: 14.sp,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: const Color(0xFF6BC799),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      /// Social Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color(0xFF469271),
                                Color(0xFF49A893),
                              ]),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Image.asset(
                              IconPath.google,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                          SizedBox(width: 19.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color(0xFF469271),
                                Color(0xFF49A893),
                              ]),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Image.asset(
                              IconPath.apple,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 42.h),
                    ],
                  ),

                  /// CTA Button
                  CustomButton(
                    text: "Comenzar mi transformación",
                    onPressed: () {
                      context.push("/loginVerifyOtp");
                    },
                    suffixIcon: Icons.arrow_forward,
                    backgroundGradient: const LinearGradient(
                      colors: [
                        Color(0xFF4FAF84),
                        Color(0xFF3D8E70),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  /// Sign up row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "¿No tienes una cuenta? ",
                        color: const Color(0xFF6B7280),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/createAccount");
                        },
                        child: CustomText(
                          text: "Crear cuenta",
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}