import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionCard extends StatelessWidget {
  final String label, value;
  const PositionCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D21),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
          Text(value, style: TextStyle(color: const Color(0xFF469271), fontSize: 24.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}