import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/provider/week_meal_provider.dart';

class MealCard extends ConsumerWidget {
  const MealCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(currentMealProvider);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2421),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFF2D3433)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF243B33),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              meal.imageIcon,
              height: 24.h,
              width: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: meal.category.toUpperCase(),
                      fontSize: 10.sp,
                      color: const Color(0xFF469271),
                      fontWeight: FontWeight.w400,
                    ),
                    Image.asset(IconPath.repeat,height: 16.h, width: 16.h,)
                  ],
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: meal.title,
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: meal.description,
                  fontSize: 12.sp,
                  color: const Color(0xFF8E95A2).withOpacity(0.7),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Image.asset(IconPath.chef, height: 18.h, width: 18.h, color: const Color(0xFF6BC799)),
                    SizedBox(width: 8.w),
                    CustomText(
                      text: meal.chefName,
                      fontSize: 12.sp,
                      color: const Color(0xFF6BC799),
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}