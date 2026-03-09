import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/widget/week_entertainment.dart';
import 'package:meal_planning/features/week/widget/week_plan.dart';

class PlanYourWeakPopup extends ConsumerWidget {
  const PlanYourWeakPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F161E),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF2FC67A).withValues(alpha: 0.20),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Planifica tu semana",
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: "Para ajustar el plan a tu semana real",
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Container(
            width: 48.w,
            height: 48.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color(0xFF469271),
                Color(0xFF49A893),
              ])
            ),
            child: Center(
              child: Image.asset(
                IconPath.calender17,
                height: 24.h,
                width: 24.w,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 16.h),
          CustomText(
            text: "¿Qué días puedes entrenar?",
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: "Selecciona los días que tienes disponibles",
            fontSize: 14.sp,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          const WeekPlan(),

          SizedBox(height: 32.h),
          CustomButton(text: "Siguiente",
              onPressed: ()=>Navigator.pop(context)
          )

        ],
      ),
    );
  }
}