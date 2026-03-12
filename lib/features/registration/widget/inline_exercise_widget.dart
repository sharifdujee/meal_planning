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
    // We watch the provider to ensure the UI reacts to state changes
    final notifier = ref.read(workoutProvider.notifier);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: workoutExercise.isEditing
          ? _buildEditForm(context, ref, notifier)
          : _buildSummary(context, ref, notifier),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    WidgetRef ref,
    WorkoutNotifier notifier,
  ) {
    return Container(
      key: ValueKey("summary_${workoutExercise.id}"),
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF6B7280),
            ),
            onPressed: () => notifier.toggleEdit(workoutExercise.id),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(
    BuildContext context,
    WidgetRef ref,
    WorkoutNotifier notifier,
  ) {
    return Container(
      key: ValueKey("edit_${workoutExercise.id}"),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF111213),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF469271), width: 1),
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

          _buildFieldLabel("Nombre del ejercicio"),
          _buildTextField(hint: "Ej: Pecho y tríceps"),
          SizedBox(height: 16.h),

          _buildFieldLabel("Descanso"),
          _buildTextField(hint: "1"),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CustomText(
              text:
                  "Se guardará como: ${workoutExercise.restTimeInMinutes}:00 (1 min)",
              color: const Color(0xFF6B7280),
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 20.h),
          const CustomText(
            text: "Series",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12.h),

          // Headers for sets
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: "Repeticiones",
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomText(
                  text: "Peso (kg)",
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 40.w), // Space for delete icon
            ],
          ),
          SizedBox(height: 8.h),

          // Dynamic Sets List
          ...workoutExercise.sets.map((set) => _buildSetRow(set)).toList(),

          SizedBox(height: 12.h),
          _buildAddButton(
            text: "Agregar serie",
            onTap: () => /* notifier.addSet(workoutExercise.id) */ null,
          ),

          SizedBox(height: 24.h),
          Center(
            child: GestureDetector(
              onTap: () => /* notifier.deleteExercise(workoutExercise.id) */
                  null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: const Color(0xFFEF4444),
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: "Eliminar ejercicio",
                    color: const Color(0xFFEF4444),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  text: "Volver",
                  onTap: () => notifier.toggleEdit(workoutExercise.id),
                  isOutlined: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _actionButton(
                  text: "Enviar",
                  onTap: () => notifier.toggleEdit(workoutExercise.id),
                  isOutlined: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSetRow(WorkoutSet set) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(child: _buildTextField(hint: "${set.reps}")),
          SizedBox(width: 12.w),
          Expanded(child: _buildTextField(hint: "${set.weight}")),
          SizedBox(width: 8.w),
          Icon(
            Icons.delete_outline,
            color: const Color(0xFFEF4444),
            size: 24.r,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF6B7280)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildAddButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(color: const Color(0xFF374151)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            CustomText(
              text: text,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
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
