import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/registration/model/workout_set.dart';
import 'package:meal_planning/features/week/model/workout_day.dart';

import '../../../core/global/custom_text.dart';
import '../provider/workout_provider.dart';

class InlineExerciseWidget extends ConsumerWidget {
  final WorkoutExercise workoutExercise;
  const InlineExerciseWidget({super.key, required this.workoutExercise});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifire = ref.read(workoutProvider.notifier);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: workoutExercise.isEditing
          ? _buildEditForm(context, ref)
          : _buildSummary(context, ref),
    );
  }

  Widget _buildSummary(BuildContext context, WidgetRef ref) {
    final notifire = ref.read(workoutProvider.notifier);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B1C),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2E30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF2D3A35),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomText(
              text: "${workoutExercise.sets.length}",
              color: const Color(0xFF469271),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: workoutExercise.name.isEmpty
                    ? "Nuevo Ejercicio"
                    : workoutExercise.name,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text:
                    "${workoutExercise.sets.length} Serie • ${workoutExercise.restTimeInMinutes} min",
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            onPressed: () {
              notifire.toggleEdit(workoutExercise.id);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(
          0xFF111213,
        ), // Slightly darker to distinguish editing
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF469271), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Editar ejercicio",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),

          // Reusable Input Fields (Nombre, Descanso, etc.)
          _buildFieldLabel("Nombre del ejercicio"),
          CustomText(text: "Ej: Press de banca"),
          SizedBox(height: 16.h),
          _buildFieldLabel("Descanso"),
          CustomText(text: "1"),

          SizedBox(height: 20.h),

          // Sets Section
          const CustomText(
            text: "Series",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),

          // ... Loop through sets here ...
          SizedBox(height: 20.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  text: "Volver",
                  onTap: () => ref
                      .read(workoutProvider.notifier)
                      .toggleEdit(workoutExercise.id),
                  isOutlined: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _actionButton(
                  text: "Enviar",
                  onTap: () => /* Logic to save values */ null,
                  isOutlined: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: label,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  Widget _actionButton({
    required String text,
    required VoidCallback onTap,
    required bool isOutlined,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFF469271),
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(color: const Color(0xFF469271), width: 1),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isOutlined ? const Color(0xFF469271) : Colors.white,
          ),
        ),
      ),
    );
  }
}
