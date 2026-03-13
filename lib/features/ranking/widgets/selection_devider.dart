import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionDevider extends StatelessWidget {
  const SelectionDevider({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: const Color(0xFF459473).withOpacity(0.3), thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF459473),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(child: Divider(color: const Color(0xFF459473).withOpacity(0.3), thickness: 1)),
        ],
      ),
    );
  }
}