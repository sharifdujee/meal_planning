import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/ranking/widgets/classification_user_tile.dart';
import 'package:meal_planning/features/ranking/widgets/position_card.dart';
import 'package:meal_planning/features/ranking/widgets/selection_devider.dart';
import '../../../../core/global/custom_text.dart';
import '../provider/classification_notifier.dart';
import 'filter_toggle.dart';

class ClassificationView extends ConsumerWidget {
  const ClassificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(classificationProvider);
    final notifier = ref.read(classificationProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Filter 1: TimeFrame ---
        FilterToggle<TimeFrame>(
          values: TimeFrame.values,
          selectedValue: state.timeFrame,
          labelBuilder: (tf) => tf.label,
          onSelected: notifier.setTimeFrame,
        ),

        SizedBox(height: 12.h),
        FilterToggle<LocationScope>(
          values: LocationScope.values,
          selectedValue: state.locationScope,
          labelBuilder: (ls) => ls.label,
          onSelected: notifier.setLocationScope,
          iconBuilder: (val) {
            switch (val) {
              case LocationScope.pueblo:
                return IconPath.locationPueblo;
              case LocationScope.ciudad:
                return IconPath.locationCity;
              case LocationScope.pais:
                return IconPath.locationEarth;
            }
          },
        ),

        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(child: const PositionCard(label: "POSICIÓN MONTORO", value: "#15")),
            SizedBox(width: 12.w),
            Expanded(child: const PositionCard(label: "POSICIÓN ESPAÑA", value: "#1287")),
          ],
        ),

        SizedBox(height: 32.h),

        _buildInfoBanner(),

        SizedBox(height: 24.h),

        CustomText(
          text: "TABLA DE LÍDERES",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        SizedBox(height: 16.h),

        if (state.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: CircularProgressIndicator(color: Color(0xFF469271)),
            ),
          )
        else ...[
          const SelectionDevider(label: "ZONA DE ASCENSO (1-5)"),
          SizedBox(height: 16.h),
          ...state.users
              .where((u) => u.rank <= 5)
              .map((u) => ClassificationUserTile(user: u)),

          SizedBox(height: 24.h),

          const SelectionDevider(label: "ZONA SEGURA (6-15)"),
          SizedBox(height: 16.h),
          ...state.users
              .where((u) => u.rank > 5)
              .map((u) => ClassificationUserTile(user: u)),
        ],
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: const Color(0xFF202122).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 1.w,
            color: const Color(0xFF383A42).withValues(alpha: 0.4),
          )),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6BC799).withValues(alpha: 0.2),
            ),
            child: Image.asset(
              IconPath.champion,
              height: 20.h,
              width: 20.h,
              color: const Color(0xFF6BC799),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Córdoba",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: "Clasificaciones más altas de esta semana",
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}