import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/custom_text.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Bronze Badge Icon (Replace with your actual asset)
          Container(
            height: 50.h,
            width: 50.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF3D2B1F), // Dark bronze background
            ),
            child: Icon(Icons.emoji_events, color: Colors.orange[300], size: 30.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Bronce III", color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                CustomText(text: "Finaliza en 2d 16h", color: Colors.grey, fontSize: 12.sp),
              ],
            ),
          ),
          // Racha Icon
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange, size: 16.w),
                SizedBox(width: 4.w),
                CustomText(text: "7d", color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}