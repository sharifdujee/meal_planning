import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planning/features/week/widget/plan_your_weak_popup.dart';
import 'package:meal_planning/features/week/widget/week_meal.dart';
import 'package:meal_planning/features/week/widget/workout_day_list.dart';

import '../../provider/week_meal_provider.dart';

import '../../widget/Quote_Card.dart';
import '../../widget/week_entertainment.dart';

class WeekScreen extends ConsumerWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              stops: const [
                0.0,
                0.05,
              ], // green fades out by 35% of screen height
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 145.w,
                    vertical: 15.h,
                  ),

                  child: CustomText(
                    text: "Semana",
                    color: Colors.white,
                    textAlign: TextAlign.center,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),

                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1C3930),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Image.asset(
                            IconPath.calender17,
                            height: 24.h,
                            width: 24.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Tu semana", fontSize: 20.sp),
                          CustomText(
                            text: "Todo planeado para ti",
                            fontSize: 12.sp,
                            color: AppColor.textBody,
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: AlignmentGeometry.topLeft,
                            end: AlignmentGeometry.bottomRight,
                            colors: [Color(0xFF469271), Color(0xFF49A893)],
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              barrierDismissible: true, // Allows tapping outside to close
                              barrierColor: Colors.black87, // Darker overlay for better focus
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.symmetric(horizontal: 20.w), // Control side margins
                                  child: PlanYourWeakPopup(),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Image.asset(
                              IconPath.filter,
                              height: 24.h,
                              width: 24.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                QuoteCard(),
                SizedBox(height: 24.h),
                Container(
                  width: 335.w,
                  height: 80.h,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: Colors.white10, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C3930),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        child: Image.asset(
                          IconPath.calender17,
                          height: 24.h,
                          width: 24.w,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tu objetivo',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'Desarrollar músculo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                WeekEntertainmentWidget(),
                SizedBox(),
                WorkoutDayList(),
                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        text: "Tu dieta semanal",
                        color: Colors.white,
                        fontSize: 20.h,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Color(0xFF38755A),
                            width: 1,
                          ),
                        ),
                        child: CustomText(
                          text: "Lista de compras",
                          fontSize: 16.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // show each day plan as its own WeekMeal card
                Builder(
                  builder: (context) {
                    final plans = ref.watch(weekMealProvider);
                    return Column(
                      children: plans.map((plan) {
                        return ProviderScope(
                          overrides: [
                            currentDayPlanProvider.overrideWithValue(plan),
                          ],
                          child: const WeekMeal(),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
