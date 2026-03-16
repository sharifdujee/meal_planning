import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import '../../../core/global/custom_text.dart';
import '../model/ranking_user.dart';

class ClassificationUserTile extends StatelessWidget {
  final RankingUser user;

  const ClassificationUserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // Logic matches RankingUser properties: 'isMe' and 'name'
    final bool isMe = user.isMe || user.name == "Tú";

    // Rank Badge Logic - Exactly the same design
    Widget buildRankIndicator() {
      if (user.rank == 1) return Image.asset(IconPath.crawn, height: 20.h, width: 20.w);
      if (user.rank == 2) return Image.asset(IconPath.silverBadge_2, height: 20.h, width: 20.w);
      if (user.rank == 3) return Image.asset(IconPath.bronzeBadge_2, height: 20.h, width: 20.w);

      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F3831),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: CustomText(
            text: "${user.rank}",
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: isMe
            ? const Color(0xFF469271).withOpacity(0.15)
            : const Color(0xFF161B1F),
        borderRadius: BorderRadius.circular(16.r),
        border: isMe
            ? Border.all(color: const Color(0xFF469271).withOpacity(0.4), width: 1)
            : Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Row(
        children: [
          // Rank Badge or Number
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: buildRankIndicator(),
          ),
          SizedBox(width: 12.w),

          // User Avatar - Using imageUrl from RankingUser
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: user.imageUrl.startsWith('http')
                ? Image.network(
              user.imageUrl,
              height: 40.h,
              width: 40.w,
              fit: BoxFit.cover,
            )
                : Image.asset(
              user.imageUrl,
              height: 40.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // User Info (Name + Streak)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: user.name,
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: isMe ? FontWeight.w600 : FontWeight.w400,
                ),
                // Streak is an int in our model, showing as "X días"
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Image.asset(IconPath.fire, height: 13.h, width: 13.w),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomText(
                        text: "${user.streak} días",
                        color: const Color(0xFF6B7280),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Score/Points - Using 'points' from RankingUser
          Column(
            children: [
              Row(
                children: [
                  CustomText(
                    text: "${user.points}",
                    color: const Color(0xFF469271),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 4.w),
                  Image.asset(
                    IconPath.arrowDown,
                    height: 12.h,
                    width: 12.w,
                    color: const Color(0xFF469271),
                  )
                ],
              ),
              CustomText(
                text: "pts",
                color: const Color(0xFF5B616E),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}