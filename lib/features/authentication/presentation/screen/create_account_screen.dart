

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                /// TOP BAR
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

                SizedBox(height: 30.h),

                /// ICON
                Image.asset(IconPath.appLogo, height: 42.h, width: 57.w),

                SizedBox(height: 24.h),

                /// TITLE
                CustomText(
                  text: "Crea tu cuenta",
                  textAlign: TextAlign.center,

                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),

                SizedBox(height: 8.h),

                /// SUBTITLE
                CustomText(
                  text:
                  "Crea tu cuenta",
                  textAlign: TextAlign.center,

                  fontSize: 14.sp,
                  color: Colors.white70,
                ),

                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: notifier.passwordController,
                  hintText: "*****",
                  obscureText: !state.isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: notifier.toggleConfirmPasswordVisibility,
                    child: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.sp,
                    ),
                  ),
                ),

                /// NEW PASSWORD
                SizedBox(height: 20.h),
                CustomText(text: "Confirmar  Contraseña ", fontWeight: FontWeight.w500,fontSize: 16.sp,color: Colors.white,),

                /// CONFIRM PASSWORD
                CustomTextFormField(
                  controller: notifier.confirmPasswordController,
                  hintText: "*****",
                  obscureText: !state.isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: notifier.toggleConfirmPasswordVisibility,
                    child: Icon(
                      state.isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.sp,
                    ),
                  ),
                ),

                const Spacer(),

                /// SUBMIT BUTTON
                SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child:CustomButton(text: "Entregar", onPressed: () {
                      showCustomDialog(
                        context,
                        imagePath: IconPath.success,
                        title: 'Contraseña cambiada',
                        buttonText: "Iniciar sesión",
                        message:
                        "Contraseña cambiada con éxito, puedes iniciar sesión nuevamente con la nueva contraseña",
                        onPressed: () {
                          context.push("/login");
                        },
                      );
                    },)),


                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
