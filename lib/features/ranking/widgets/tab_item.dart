import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../model/ranking_page State.dart';
import '../provider/ranking_notifier.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.ref,
    required this.label,
    required this.tab,
    required this.isSelected,
    required this.activeIcon,
  });

  final WidgetRef ref;
  final String label;
  final RankingTab tab;
  final bool isSelected;
  final String activeIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTap: () => ref.read(rankingNotifierProvider.notifier).setTab(tab),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF469271) : Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  activeIcon,
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class TabSwitcher extends StatelessWidget {
  const TabSwitcher({
    super.key,
    required this.ref,
    required this.activeTab,
  });

  final WidgetRef ref;
  final RankingTab activeTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6BC799).withOpacity(0.16),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          TabItem(
            ref: ref,
            label: "Compite",
            tab: RankingTab.compite,
            isSelected: activeTab == RankingTab.compite,
            activeIcon: IconPath.frame,
          ),
          TabItem(
            ref: ref,
            label: "Clasificaciones",
            tab: RankingTab.clasificaciones,
            isSelected: activeTab == RankingTab.clasificaciones,
            activeIcon: IconPath.analytics,
          ),
        ],
      ),
    );
  }
}