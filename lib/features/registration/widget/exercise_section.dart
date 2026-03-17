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

class ExerciseSection extends ConsumerWidget {
  const ExerciseSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutExercises = ref.watch(workoutProvider);
    final notifier = ref.read(workoutProvider.notifier);

    return Column(
      children: [
        // Header Row
        Row(
          children: [
            Image.asset(IconPath.dumbbell, height: 20.h, width: 20.w, color: Colors.white),
            SizedBox(width: 8.w),
            CustomText(
              text: "Ejercicio",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            const Spacer(),
            CustomText(
              text: "${workoutExercises.length} ejercicios",
              color: const Color(0xFF6B7280), // Using a grey to match your design
              fontSize: 14.sp,
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Content
        if (workoutExercises.isEmpty)
          _buildEmptyState(context, notifier)
        else ...[
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workoutExercises.length,
            itemBuilder: (context, index) {
              return InlineExerciseWidget(workoutExercise: workoutExercises[index]);
            },
          ),
          SizedBox(height: 12.h),
          // Button appears below the list when not empty
          _buildAddButton(onTap: () => notifier.addExercise(), isFullWidth: true),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, WorkoutNotifier notifier) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B1C),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 1, color: const Color(0xFF2D2E30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(IconPath.dumbbell, height: 40.h, width: 40.h, color: const Color(0xFF383A42)),
          SizedBox(height: 16.h),
          CustomText(
            text: "Añade al menos un ejercicio",
            color: const Color(0xFF6B7280),
            fontSize: 14.sp,
          ),
          SizedBox(height: 16.h),
          _buildAddButton(
            onTap: () => notifier.addExercise(),
            isFullWidth: false,
          )
        ],
      ),
    );
  }

  Widget _buildAddButton({required VoidCallback onTap, required bool isFullWidth}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // If it's not full width (empty state), we give it some horizontal padding
        width: isFullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(width: 1, color: const Color(0xFF2D2E30)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, // Centering logic
          children: [
            Icon(Icons.add, size: 20.r, color: Colors.white),
            SizedBox(width: 8.w),
            CustomText(
              text: "Añadir ejercicio",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}