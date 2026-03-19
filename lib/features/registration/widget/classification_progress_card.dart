import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/registration/provider/classification_provider.dart';

class ClassificationProgressCard extends ConsumerWidget {
  const ClassificationProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider (StateNotifierProvider)
    final progress = ref.watch(classificationProvider);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1, color: const Color(0xFF383A42)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Image.asset(IconPath.lock, height: 24.h, width: 24.w),
                SizedBox(width: 8.w),
                CustomText(
                  text: "Progreso de clasificación",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const Spacer(),
                CustomText(
                  text: "${progress.totalPointsDisplay} pts",
                  fontSize: 14.sp,
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: const Divider(color: Color(0xFF383A42)),
            ),

            // Progress Items
            _buildProgressItem(
              label: "Porcentaje de series registradas",
              progressIcon: IconPath.energy,
              value: "${progress.currentSeries}/${progress.totalSeries} series",
              percent: progress.seriesProgress,
            ),
            SizedBox(height: 12.h),
            _buildProgressItem(
              label: "Tiempo",
              progressIcon: IconPath.clock,
              value: "${progress.currentMinutes}/${progress.totalMinutes} min",
              percent: progress.timeProgress,
            ),
            SizedBox(height: 12.h),
            _buildProgressItem(
              label: "Puntos obtenidos en vivo",
              progressIcon: IconPath.pointRight,
              value: "${progress.currentPoints}/${progress.goalPoints} pts",
              percent: progress.pointProgress,
            ),

            // Hints List (Replaced ListView with map for performance)
            if (progress.pointHints.isNotEmpty) ...[
              SizedBox(height: 16.h),
              ...progress.pointHints.map((hint) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: CustomText(
                  text: hint,
                  fontSize: 12.sp,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem({
    required String label,
    required String progressIcon,
    required String value,
    required double percent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label, // FIXED: Now uses the passed parameter
          color: const Color(0xFF6B7280),
          fontSize: 12.sp,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Image.asset(
              progressIcon,
              height: 16.h,
              width: 16.w,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 6.h,
                  backgroundColor: const Color(0xFF232425),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF469271),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            CustomText(
              text: value,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}