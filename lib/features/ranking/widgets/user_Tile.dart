import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/ranking_page State.dart';

class UserTile extends StatelessWidget {
  final UserRank user;

  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Assuming "Tú" is how you identify the current user in your logic
    bool isMe = user.name == "Tú";

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFF459473).withValues(alpha: 0.15) : const Color(0xFF1A1D21),
        borderRadius: BorderRadius.circular(12.r),
        border: isMe ? Border.all(color: const Color(0xFF459473).withValues(alpha: 0.5)) : null,
      ),
      child: Row(
        children: [
          // Rank Number
          Text(
            "${user.rank}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(width: 16.w),
          // User Name
          Expanded(
            child: Text(
              user.name,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
          // Points
          Text(
            "${user.score} pts",
            style: TextStyle(color: const Color(0xFF459473), fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}