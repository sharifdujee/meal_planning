import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/global/custom_text_form_field.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                SizedBox(height: 80.h),

                /// Logo
                Image.asset(
                  IconPath.appLogo,
                  width: 60.w,
                  height: 45.h,
                ),

                SizedBox(height: 24.h),

                /// Title
                CustomText(
                  text: "Restablecer contraseña",
                  color: AppColor.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                /// Subtitle
                CustomText(
                  text:
                  "Introduce tu correo electrónico para recibir un código de verificación.",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColor.textBody,
                ),

                SizedBox(height: 40.h),

                /// Email Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Dirección de correo electrónico",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 12.h),

                /// Email Field
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Dirección de correo electrónico",
                ),

                const Spacer(),

                /// Send Button
                CustomButton(
                  text: "Enviar código",
                  onPressed: () {
                    context.push("/forgotOtpVerification");
                  },
                  suffixIcon: Icons.arrow_forward,
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}