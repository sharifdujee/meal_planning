import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/custom_text.dart';
import '../model/workout_day.dart';

class ExerciseTile extends ConsumerStatefulWidget {
  final int number;
  final Exercise exercise;

  const ExerciseTile({
    super.key,
    required this.number,
    required this.exercise,
  });

  @override
  ConsumerState<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends ConsumerState<ExerciseTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isExpanded ? const Color(0xFF10151B) : const Color(0xFF6BC799).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
              width: 1,
              color: isExpanded ? const Color(0xFF6BC799).withValues(alpha: 0.2) : const Color(0xFF383A42)
          ),
        ),
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF469271).withValues(alpha: 0.30),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: CustomText(
                      text: "${widget.number}",
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomText(
                    text: widget.exercise.name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                CustomText(
                  text: widget.exercise.setsAndReps,
                  color: const Color(0xFFFFFFFF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),

              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(left: 44.w),
                child: Row(
                  children: [
                    const Icon(Icons.help_outline, size: 14, color: Color(0xFF6BC799)),
                    SizedBox(width: 4.w),
                    CustomText(
                      text: "Ver explicación",
                      color: const Color(0xFF6BC799),
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),


            // Detailed Content Section
            if (isExpanded) ...[
              SizedBox(height: 20.h),

              // 1. Muscles Worked
              _buildSectionHeader(1, "¿Que músculos trabaja?"),
              _buildContentPadding(
                CustomText(
                  text: widget.exercise.targetMuscles ?? "",
                  color: const Color(0xFF6BC799),
                  fontSize: 14.sp,
                ),
              ),

              // 2. Positioning
              SizedBox(height: 16.h),
              _buildSectionHeader(2, "Cómo posicionarse"),
              ...widget.exercise.positioningSteps.map((step) => _buildBulletPoint(step)),

              // 3. Execution (Solid Black Box)
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    _buildSectionHeader(3, "Como ejecutar"),
                    ...widget.exercise.executionSteps.map((step) => _buildBulletPoint(step)),
                  ],
                ),
              ),

              // 4. Success Signal
              SizedBox(height: 16.h),
              _buildSectionHeader(4, "Señal de que lo estás haciendo bien"),
              if (widget.exercise.successSignal != null)
                _buildBulletPoint(widget.exercise.successSignal!),

              // 5. Common Error
              SizedBox(height: 16.h),
              _buildSectionHeader(5, "Error común", isError: true),
              if (widget.exercise.commonError != null)
                _buildBulletPoint(widget.exercise.commonError!),
            ],
          ],
        ),
      ),
    );
  }

  // UI Helper for the small numbered section boxes
  Widget _buildSectionHeader(int num, String title, {bool isError = false}) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isError ? Colors.red.withOpacity(0.2) : const Color(0xFF6BC799).withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: CustomText(
            text: "$num",
            fontSize: 10.sp,
            color: isError ? Colors.redAccent : const Color(0xFF6BC799),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isError ? Colors.redAccent : Colors.white,
        ),
      ],
    );
  }

  Widget _buildContentPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w, top: 4.h),
      child: child,
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w, top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "• ", color: const Color(0xFF6B7280)),
          Expanded(
            child: CustomText(
              text: text,
              fontSize: 12.sp,
              color: const Color(0xFF8E95A2),
            ),
          ),
        ],
      ),
    );
  }
}