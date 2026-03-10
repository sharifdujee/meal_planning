import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/core/utils/image_path.dart';
import 'package:meal_planning/features/week/model/workout_day.dart';

class WorkoutDetailSheet extends StatelessWidget{
  final WorkoutDay day;

  const WorkoutDetailSheet({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF10151B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32))
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: EdgeInsetsGeometry.only(top: 12.h, bottom: 20.h),
              width: 70.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(24)
              ),
            ),
          ),
          //Header Section

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Color(0xFF6BC799),
                    borderRadius: BorderRadius.circular(12.r)
                  ),
                  child: Image.asset(IconPath.restaurant02,height: 20.h, width: 20.w,),
                ),
                SizedBox(width: 8.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: day.dayName,
                      fontSize: 16.h,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "${day.description} . ${day.minutes?? '0'} min",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6BC799),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16.h,),

        ],
      ),
    );
  }

}