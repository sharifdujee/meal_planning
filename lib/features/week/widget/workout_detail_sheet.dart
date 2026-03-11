import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/core/utils/image_path.dart';
import 'package:meal_planning/features/week/model/workout_day.dart';

import 'exercise_tile.dart';

class WorkoutDetailSheet extends StatelessWidget {
  final WorkoutDay day;

  const WorkoutDetailSheet({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF10151B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle (Non-scrollable part)
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 70.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6BC799),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            IconPath.restaurant02,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: day.dayName,
                              fontSize: 16.h,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: "${day.description} . ${day.minutes ?? '0'} min",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF6BC799),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Instructions List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    itemCount: day.instructions.length,
                    itemBuilder: (context, instructionIndex) {
                      final instruction = day.instructions[instructionIndex];
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFF192727),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(IconPath.idea1, height: 24.h, width: 24.h),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomText(
                                text: instruction.text,
                                fontSize: 12.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Routine List
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Rutina",
                          fontSize: 16.sp,
                          color: Color(0xFF6BC799),
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        CustomText(
                          text: "${day.exercises.length} ejercicios",
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: day.exercises.length,
                    itemBuilder: (context, index) {
                      return ExerciseTile(
                        number: index + 1,
                        exercise: day.exercises[index],
                      );
                    },
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}