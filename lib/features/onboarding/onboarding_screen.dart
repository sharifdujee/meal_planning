import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/design_system/app_color.dart';
import '../../core/utils/icon_path.dart';
import '../../core/global/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                SizedBox(height: 110.h),

                /// Logo
                Image.asset(
                  IconPath.appLogo,
                  width: 140.w,
                  height: 140.w,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 30.h),

                /// Title
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "IMPER",
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF49B37D),
                        ),
                      ),
                      TextSpan(
                        text: "FECTO",
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// Subtitle
                Text(
                  "Progreso real, sin castigo.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9AA4AF),
                    height: 1.6,

                  ),
                ),

                const Spacer(),

                /// Begin Button
                CustomButton(
                  text: "Comenzar",
                  onPressed: () {
                    context.push('/profileSetUp');

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

                /// Login Button
                CustomButton(
                  text: "Ya tengo una cuenta",
                  onPressed: () {
                    ///context.push('/profileSetUp');
                    context.push('/login');
                  },

                  prefixIcon: Icons.person_outline, // ✅ example usage
                  textColor: AppColor.textBody,
                  isOutlined: true,
                ),

                SizedBox(height: 28.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}