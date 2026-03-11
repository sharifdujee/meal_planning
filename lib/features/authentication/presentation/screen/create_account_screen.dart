

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/design_system/app_color.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_form_field.dart';
import '../../../../core/global/show_custom_dialog.dart';

import '../../../../core/utils/icon_path.dart';
import '../../provider/resset_password_provider.dart';

class CreateAccountScreen extends ConsumerWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                /// TOP BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

                SizedBox(height: 10.h),

                /// LOGO
                Image.asset(
                  IconPath.appLogo,
                  height: 44.h,
                ),

                SizedBox(height: 24.h),

                /// TITLE
                CustomText(
                  text: "Crea tu cuenta",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 6.h),

                /// SUBTITLE
                CustomText(
                  text: "Crea tu cuenta",
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: .6),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h),

                /// EMAIL
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Correo electrónico",
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),

                CustomTextFormField(
                  controller: notifier.emailController,
                  hintText: "abc@gmail.com",
                ),

                SizedBox(height: 20.h),

                /// PASSWORD
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Contraseña",
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),

                CustomTextFormField(
                  controller: notifier.passwordController,
                  hintText: "••••••••",
                  obscureText: !state.isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: notifier.togglePasswordVisibility,
                    child: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.sp,
                      color: Colors.white54,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                /// CONFIRM PASSWORD
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Confirmar contraseña",
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),

                CustomTextFormField(
                  controller: notifier.confirmPasswordController,
                  hintText: "••••••••",
                  obscureText: !state.isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: notifier.toggleConfirmPasswordVisibility,
                    child: Icon(
                      state.isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.sp,
                      color: Colors.white54,
                    ),
                  ),
                ),

                const Spacer(),

                /// CREATE ACCOUNT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: CustomButton(
                    text: "Crear cuenta",
                    borderRadius: 14.r,
                    onPressed: () {
                      context.push(("/signUpOtpVerification"));
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                /// BOTTOM LOGIN TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "¿Ya tienes una cuenta?",
                      fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 6.w),
                    GestureDetector(
                      onTap: (){
                        context.push("/login");
                      },
                      child: CustomText(
                        text: "Iniciar sesión",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

      ),
    );
  }


}


///