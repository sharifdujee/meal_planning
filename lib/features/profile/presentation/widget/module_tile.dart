import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design_system/app_color.dart';
import '../../modal/active_module.dart';

class ModuleTile extends StatelessWidget {
  final ActiveModule module;
  final bool showDivider;
  final VoidCallback onToggle;

  const ModuleTile({super.key,
    required this.module,
    required this.showDivider,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                height: 36.h,
                width: 36.w,
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xFF1C3930),
                ),
                child: Icon(module.icon, color: AppColor.primary, size: 18.r),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      module.subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColor.textBody,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Switch(
                value: module.isEnabled,
                onChanged: (_) => onToggle(),

                activeTrackColor: AppColor.primary.withValues(alpha: 0.3),
                activeThumbColor: AppColor.white,
                inactiveThumbColor: AppColor.textBody,
                inactiveTrackColor: AppColor.white,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColor.cardBorder,
          ),
      ],
    );
  }
}