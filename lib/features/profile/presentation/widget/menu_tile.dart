import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';

import 'menu_item.dart';

class MenuTile extends StatelessWidget {
  final MenuItem item;
  final bool showDivider;

  const MenuTile({super.key, required this.item, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final color = item.textColor ?? AppColor.white;
    return Column(
      children: [
        InkWell(
          onTap: item.onTap ?? () {},
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Image.asset(item.icon, color: color, height: 24.h,width: 24.w,),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                if (item.textColor == null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.textBody,
                    size: 14.r,
                  ),
              ],
            ),
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