import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/registration/provider/workout_provider.dart';

import '../model/workout_set.dart';
import 'inline_exercise_widget.dart';

class ExerciseSection extends ConsumerWidget{
  const ExerciseSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutExercises = ref.watch(workoutProvider);
    final notifier = ref.read(workoutProvider.notifier);
    return Column(
      children: [
        Row(
          children: [
            Image.asset(IconPath.dumbbell,height: 20.h,width: 20.w,color: Colors.white,),
            SizedBox(width: 8.w,),
            CustomText(
              text: "Ejercicio",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
            Spacer(),
            CustomText(
              text: "${workoutExercises.length} ejercicios", color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        if (workoutExercises.isEmpty)
          _buildEmptyState(context, notifier)
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workoutExercises.length,
            itemBuilder: (context, index){
              return InlineExerciseWidget(workoutExercise: workoutExercises[index]);            },
          ),
          SizedBox(height: 24.h,),
          _buildAddButton(onTap: () =>notifier.addExercise(), isFullWidth: true),
      ],
    );
  }
  Widget _buildEmptyState(BuildContext context,WorkoutNotifier notifier){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
      decoration: BoxDecoration(
        color: Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1,color: Color(0xFF383A42))
      ),
      child: Column(
        children: [
          Image.asset(IconPath.dumbbell,height: 40.h,width: 40.h,color: Color(0xFF6B7280),),
          SizedBox(height: 12.h,),
          CustomText(
            text: "Añade al menos un ejercicio",
            color: Color(0xFF5B616E),
          ),
          SizedBox(height: 12.h,),
          _buildAddButton(
            onTap: () => notifier.addExercise(),
              isFullWidth: false
          )
        ],
      ),
    );
  }

  Widget _buildAddButton({required VoidCallback onTap, required bool isFullWidth}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(width: 1,color: Color(0xFF40444C))
        ),
        child: Row(
          children: [
            Icon(Icons.add,size: 24.r,),
            SizedBox(width: 8.w,),
            CustomText(
              text: "Añadir ejercicio",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

}