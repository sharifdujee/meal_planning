import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';

import '../provider/ranking_state_notifier.dart';

class RankingStatsRow extends ConsumerWidget {
  const RankingStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(rankingStatsProvider);

    return Row(
      children: [
        // Position Card
        Expanded(
          child: _StatCard(
            title: "POSICIÓN",
            value: "#${stats.currentPosition}",
            subtitle: "De ${stats.totalParticipants}",
          ),
        ),
        SizedBox(width: 12.w),
        // Points Card
        Expanded(
          child: _StatCard(
            title: "PUNTOS",
            value: "${stats.weeklyPoints}",
            subtitle: "Esta semana",
            valueColor: const Color(0xFF6BC799),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color? valueColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2E2A).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Color(0xFF383A42),width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: title,
            color: Color(0xFF8E95A2),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: value,
            color: valueColor ?? Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: subtitle,
            color: Color(0xFF8E95A2),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}