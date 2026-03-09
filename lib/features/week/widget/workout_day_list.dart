import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/provider/workout_provider.dart';


class WorkoutDayList extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final days = ref.watch(workoutProvider);
    return SizedBox(
      width: 335.w,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: days.length,
        itemBuilder: (context,index){
          final day = days[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: day.isActive ?  Color(0xFF6BC799).withValues(alpha: 0.34): Color(0xFF6BC799).withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: day.isActive ? Colors.transparent : Color(0xFF383A42),
                  width: 1
                ),
              ),
              child: Row(
                children: [
                  //Icon box
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Color(0xFF1C3930),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Image.asset(IconPath.dumbbell,height: 24.r, width: 24.r,color: Colors.white,),
                  ),

                  SizedBox(width: 8.w,),

                  //Custom Text Container
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: day.dayName,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: day.description,
                          color: Color(0xFF6B7280),
                        )
                      ],
                    )
                  ),

                  // Minutes Timer
                  if (day.minutes!=null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
                      decoration: BoxDecoration(
                        color: day.isActive? Color(0xFF6BC799).withValues(alpha: 0.30) : Color(0xFF6B7280).withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20.r)
                      ),
                      child: CustomText(
                        text: "${day.minutes} minutos",
                        color: day.isActive ? Color(0xFFD8DBDF):Color(0xFF6B7280),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
