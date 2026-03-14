import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/custom_text.dart';

class SelectionDevider extends StatelessWidget {

  final String label;
  const SelectionDevider({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFF6BC799),width: 1)
      ),
      padding: EdgeInsets.all(10.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: const Color(0xFF6BC799), thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomText(
              text: label,
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: Divider(color: const Color(0xFF6BC799), thickness: 1)),
        ],
      ),
    );
  }
}