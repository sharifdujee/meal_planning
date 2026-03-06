import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';

class GoalCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        width: 159.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF0C2A1F)     // richer selected background
              : const Color(0xFF0F1A14),     // deeper unselected bg
          borderRadius: BorderRadius.circular(20.r), // slightly softer corners
          border: Border.all(
            color: selected
                ? AppColor.accent             // #4CAF7D or your brand green
                : Colors.transparent,
            width: selected ? 1.6 : 0,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: AppColor.accent.withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Image.asset(
              imagePath,
              width: 36.w,
              height: 36.h,
              fit: BoxFit.contain,
              // Optional: slight tint when not selected
              ///color: selected ? null : const Color(0xFF6B8A7A),
              colorBlendMode: BlendMode.srcIn,
            ),

            SizedBox(height: 14.h),

            // Label
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF9CAEA3),
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.24,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}