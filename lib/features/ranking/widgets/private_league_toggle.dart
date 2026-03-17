import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/authentication/presentation/screen/profile_set_up.dart';

import '../../../core/design_system/app_color.dart';
import '../../../core/global/custom_text.dart';
import '../provider/ranking_notifier.dart';

class PrivateLeagueToggle extends StatelessWidget {
  const PrivateLeagueToggle({
    super.key,
    required this.ref,
    required this.isEnabled,
  });

  final WidgetRef ref;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF202122), // Dark card color
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Color(0xFF383A42), // Subtle border
        ),
      ),
      child: Row(
        children: [
          // Group Icon
          Image.asset(IconPath.person,height: 24,width: 24,color: Color(0xFF469271),),
          SizedBox(width: 8 .w),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Ligas Privadas",
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: "Compite solo con amigos invitados",
                  color: Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          // The Switch
          Transform.scale(
            scale: 1, // Slightly smaller switch to match design
            child: Switch(
              value: isEnabled,
              activeColor: Color(0xFFFFFFFF),
              activeTrackColor: const Color(0xFF469271),
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: AppColor.textBody,
              onChanged: (value) {
                ref.read(rankingNotifierProvider.notifier).togglePrivateLeagues(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}