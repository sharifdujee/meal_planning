import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/custom_text.dart';
import 'day_entry.dart';


class DayTile extends StatelessWidget {
  final DayEntry entry;
  final bool isExpanded;
  final VoidCallback onToggle;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onDurationChanged;
  final ValueChanged<String> onNotesChanged;

  const DayTile({super.key,
    required this.entry,
    required this.isExpanded,
    required this.onToggle,
    required this.onTypeChanged,
    required this.onNameChanged,
    required this.onDurationChanged,
    required this.onNotesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF23292F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isExpanded
              ? const Color(0xFF469271).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          // Header row
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
              child: Row(
                children: [
                  Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF469271).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: const Color(0xFF469271),
                      size: 14.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.day,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          entry.type,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white.withValues(alpha: 0.4),
                      size: 20.r,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded fields
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.white.withValues(alpha: 0.07), height: 1),
                  SizedBox(height: 12.h),
                  CustomText(text: 'Nombre del entrenamiento', color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Nombre del entrenamiento',
                    initialValue: entry.name,
                    onChanged: onNameChanged,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(text: 'Duración (min)', color: Colors.white.withValues(alpha: .5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Duración (min)',
                    initialValue: entry.duration,
                    onChanged: onDurationChanged,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(text: 'Notas', color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Notas adicionales',
                    initialValue: entry.notes,
                    onChanged: onNotesChanged,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InlineInput extends StatelessWidget {
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int maxLines;

  const _InlineInput({
    required this.hint,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white, fontSize: 13.sp),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 12.sp),
        filled: true,
        fillColor: const Color(0xFF1A1F24),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
          const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}


class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _InputField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 13.sp),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 13.sp),
        filled: true,
        fillColor: const Color(0xFF23292F),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
          const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}