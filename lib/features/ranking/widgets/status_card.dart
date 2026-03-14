import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart'; // Import your icon paths

import '../provider/status_notifier.dart';

class StatusCard extends ConsumerWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the notifier state
    final status = ref.watch(statusNotifierProvider);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10151B),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          // Circular Badge Container
          Container(
            height: 60.h,
            width: 60.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1B2B26), // Deep green tint from your design
            ),
            child: Center(
              child: Image.asset(
                // Use the path from your IconPath utility
                IconPath.bronze3,
                height: 50.h,
                width: 50.h,
                fit: BoxFit.contain,
                // Fallback if the path is missing or incorrect
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.emoji_events, color: Colors.orange),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Data Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: status.leagueName,
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.access_time, color: const Color(0xFF6B7280), size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        text: "Quedan ${status.daysRemaining} días",
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Image.asset(IconPath.fire,height: 16.h,width: 16.w,),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        text: "Racha de ${status.reachday} días",
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}