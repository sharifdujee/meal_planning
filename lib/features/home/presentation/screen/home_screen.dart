import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/core/utils/image_path.dart';
import 'package:meal_planning/features/home/presentation/widget/exercise_screen.dart';
import 'package:meal_planning/features/home/presentation/widget/nutrition_screen.dart';
import 'package:meal_planning/features/home/presentation/widget/protein_suppliment_card.dart';
import 'package:meal_planning/features/home/presentation/widget/recovery_trainning_card.dart';
import 'package:meal_planning/features/home/presentation/widget/weekly_progress_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF469271).withValues(alpha: 0.2),
                const Color(0xFF0E1115),
              ],
              stops: const [0.0, 0.05], // green fades out by 35% of screen height
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),

                // ── Header row ─────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 22.r,
                        backgroundImage: AssetImage(ImagePath.user),
                      ),
                      SizedBox(width: 8.w),

                      // ✅ FIX: Expanded so text doesn't push badges off screen
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '¡Buenos días, Aristóteles!',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColor.white,
                            ),
                            SizedBox(height: 16.h),
                            CustomText(
                              text: 'Somos lo que hacemos repetidamente.',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.welcomeQuoteColor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 5.w),

                      // Streak badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// 🔥 Streak Circle
                          Container(
                            height: 38.h,
                            width: 38.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2A2F36).withValues(alpha: .45),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .35),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: FittedBox(
                              child: CustomText(
                                text: '7🔥',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: AppColor.primary,
                              ),
                            ),
                          ), 

                          SizedBox(width: 10.w),

                          /// 🏅 Badge Circle
                          Container(
                            height: 38.h,
                            width: 38.w,
                            padding: EdgeInsets.all(8.sp),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2A2F36).withValues(alpha: .45),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .35),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                IconPath.badge,
                                height: 200.h,
                                width: 20.w,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ── Weekly progress ───────────────────────
                const WeeklyProgressWidget(),
                SizedBox(height: 32.h),

                // ── Recovery card ─────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFF202122),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Día de Recuperación',
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: AppColor.white,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text:
                        'No te detienes. Te estás recuperando para rendir mejor mañana.',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBody,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      const RecoveryTrainingCard(),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // ── Confirm rest row ──────────────────────
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: AppColor.white, size: 18.sp),
                      SizedBox(width: 8.w),
                      // ✅ FIX: Expanded so text wraps properly
                      Expanded(
                        child: CustomText(
                          text:
                          'Confirma tu día de descanso y no pierdas la racha.',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: const Color(0xFFD8DBDF),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ── Exercise screen ───────────────────────
                const ExerciseScreen(),

                SizedBox(height: 32.h),

                // ── Nutrition title ───────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomText(
                    text: 'Tu Nutrición',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.left,
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 24.h),

                // ── Nutrition screen ──────────────────────
                const NutritionScreen(),

                SizedBox(height: 24.h),

                // ── Protein supplement card ───────────────
                const ProteinSupplementCard(),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


}