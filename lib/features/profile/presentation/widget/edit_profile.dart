import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/design_system/app_color.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController =
  TextEditingController(text: "ejemplo@gmail.com");
  final TextEditingController heightController = TextEditingController();
  final TextEditingController currentWeightController =
  TextEditingController();
  final TextEditingController targetWeightController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x33469271), // soft green fade
              Color(0xFF0E1115),
            ],
            stops: [0.0, 0.15],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                /// 🔹 Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CustomText(
                          text: "Editar perfil",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w), // balance spacing
                  ],
                ),

                SizedBox(height: 30.h),

                /// 🔹 Nombre
                _label("Nombre"),
                SizedBox(height: 8.h),
                _darkField(controller: nameController, hint: "Nombre"),

                SizedBox(height: 20.h),

                /// 🔹 Email
                _label("Dirección de correo electrónico"),
                SizedBox(height: 8.h),
                _greenField(
                  controller: emailController,
                  readOnly: true,
                ),

                SizedBox(height: 20.h),

                /// 🔹 Altura
                _label("Altura"),
                SizedBox(height: 8.h),
                _darkField(controller: heightController, hint: "Altura"),

                SizedBox(height: 20.h),

                /// 🔹 Peso actual
                _label("Peso actual (kg)"),
                SizedBox(height: 8.h),
                _darkField(
                    controller: currentWeightController,
                    hint: "Peso actual (kg)"),

                SizedBox(height: 20.h),

                /// 🔹 Peso objetivo
                _label("Peso objetivo (kg)"),
                SizedBox(height: 8.h),
                _darkField(
                    controller: targetWeightController,
                    hint: "Peso objetivo (kg)"),

                const Spacer(),

                /// 🔹 Save Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: CustomButton(
                    text: "Guardar",
                    onPressed: () {},
                    textColor: Colors.white,
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Label Widget
  Widget _label(String text) {
    return CustomText(
      text: text,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white.withValues(alpha: 0.8),
    );
  }

  /// 🔹 Dark Input Field (Like Image)
  Widget _darkField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F24),
        borderRadius: BorderRadius.circular(12.r),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// 🔹 Green Email Field
  Widget _greenField({
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: const Color(0xFF7BC6A4),
        borderRadius: BorderRadius.circular(12.r),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: const TextStyle(
          color: Color(0xFF0E1115),
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}