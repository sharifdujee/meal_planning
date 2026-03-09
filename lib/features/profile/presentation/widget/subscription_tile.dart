
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';
import '../../modal/user_profile.dart';
import '../screen/profile_screen.dart';

class SubscriptionTile extends StatelessWidget {
  final UserProfile profile;

  const SubscriptionTile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xFF1C3930),
          ),
          child: Icon(Icons.workspace_premium, color: AppColor.primary, size: 18.r),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.subscriptionType,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                profile.isSubscriptionActive
                    ? 'Suscripción activa'
                    : 'Sin suscripción',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBody,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: AppColor.textBody, size: 16.r),
      ],
    );
  }
}