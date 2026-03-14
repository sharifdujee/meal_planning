import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/features/ranking/widgets/ranking_states_row.dart';
import 'package:meal_planning/features/ranking/widgets/user_Tile.dart';
import '../model/ranking_page State.dart';
import '../widgets/private_league_toggle.dart';
import '../widgets/status_card.dart';
import '../widgets/selection_devider.dart';



class CompiteView extends ConsumerWidget {
  final RankingPageState state;

  const CompiteView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Filter users based on rank
    final promotionZoneUsers = state.users.where((user) => user.rank <= 5).toList();
    final safeZoneUsers = state.users.where((user) => user.rank > 5 && user.rank <= 15).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusCard(),
        SizedBox(height: 32.h),
        const RankingStatsRow(),
        SizedBox(height: 32.h),
        CustomText(
          text: "CLASIFICACIONES SEMANALES",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        SizedBox(height: 24.h),

        // --- ZONA DE ASCENSO (1-5) ---
        if (promotionZoneUsers.isNotEmpty) ...[
          const SelectionDevider(label: "ZONA DE ASCENSO (1-5)"),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: promotionZoneUsers.length,
            itemBuilder: (context, index) => UserTile(user: promotionZoneUsers[index]),
          ),
          SizedBox(height: 24.h),
        ],

        // --- ZONA SEGURA (6-15) ---
        if (safeZoneUsers.isNotEmpty) ...[
          const SelectionDevider(label: "ZONA SEGURA (6-15)"),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: safeZoneUsers.length,
            itemBuilder: (context, index) => UserTile(user: safeZoneUsers[index]),
          ),
        ],

        SizedBox(height: 120.h),
      ],
    );
  }
}