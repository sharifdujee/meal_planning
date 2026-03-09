import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/custom_text.dart';
import '../../../core/utils/icon_path.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 30.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF1E1E1E),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1C3930),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF383A42), width: 1),
            ),
            child: Container(
              margin: EdgeInsets.all(16.0.sp),
              child: Image.asset(
                IconPath.star,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
          CustomText(
            text: '"Tu cuerpo puede hacerlo. Es tu mente la que necesitas convencer."',
            textAlign: TextAlign.center,
            color: Colors.white,
            fontSize: 20.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            '— ANÓNIMO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}