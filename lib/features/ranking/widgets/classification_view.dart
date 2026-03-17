import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final state = ref.watch(rankingClassificationProvider);
    final notifier = ref.read(rankingClassificationProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Filter 1: Time ---
        FilterToggle<TimeFrame>(
          values: TimeFrame.values,
          selectedValue: state.timeFrame,
          labelBuilder: (tf) => tf.name,
          onSelected: notifier.setTimeFrame,
        ),
        SizedBox(height: 12.h),


        // --- Filter 2: Location ---
        FilterToggle<LocationScope>(
          values: LocationScope.values,
          selectedValue: state.locationScope,
          labelBuilder: (ls) => ls.name,
          onSelected: notifier.setLocationScope,
        ),
        SizedBox(height: 24.h),

        // Position Cards
        Row(
          children: [
            Expanded(child: PositionCard(label: "POSICIÓN MONTORO", value: "#15")),
            SizedBox(width: 12.w),
            Expanded(child: PositionCard(label: "POSICIÓN ESPAÑA", value: "#1287")),
          ],
        ),
        SizedBox(height: 32.h),

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
              padding: EdgeInsets.only(top: 40.0),
              child: CircularProgressIndicator(color: Color(0xFF469271)),
            ),
          )
        else ...[
          const SelectionDevider(label: "ZONA DE ASCENSO (1-5)"),
          ...state.users
              .where((u) => u.rank <= 5)
              .map((u) => ClassificationUserTile(user: u))
              .toList(),

          SizedBox(height: 16.h),
          const SelectionDevider(label: "ZONA SEGURA (6-15)"),
          ...state.users
              .where((u) => u.rank > 5)
              .map((u) => ClassificationUserTile(user: u))
              .toList(),
        ],

        SizedBox(height: 100.h),
      ],
    );
  }
}