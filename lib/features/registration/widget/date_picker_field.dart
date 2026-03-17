import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/registration/provider/workout_log_provider.dart';

class DatePickerField extends ConsumerWidget{
  const DatePickerField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(workoutLogProvider).date;
    final notifier = ref.read(workoutLogProvider.notifier);

    return GestureDetector(
      onTap: () => notifier.selectData(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
        decoration: BoxDecoration(
          color: Color(0xFF202122),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(0xFF383A42))
        ),
        child: Row(
          children: [
            Image.asset(IconPath.calenderToday,height: 24.h,width: 24.w,),
            SizedBox(width: 10.w,),
            CustomText(
              text: date.isEmpty ? "Seleccionar fecha" : date,
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}