
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../../widget/Quote_Card.dart';
import '../../widget/week_entertainment.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF469271).withValues(alpha: 0.2),
                const Color(0xFF0E1115),
              ],
              stops: const [0.0, 0.05], // green fades out by 35% of screen height
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 145.w,vertical: 15.h),
                  child: CustomText(
                    text: "Semana",color: Colors.white,textAlign: TextAlign.center,fontSize: 20.sp,
                  ),
                ),
                SizedBox(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1C3930)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Image.asset(IconPath.calender17,height: 24.h,width: 24.w,fit: BoxFit.contain,),
                          ),
                      ),
                      SizedBox(width: 4.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Tu semana",fontSize: 20.sp,),
                          CustomText(text: "Todo planeado para ti",fontSize: 12.sp,color: AppColor.textBody,),
                        ],
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: 97.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF469271),
                              Color(0xFF49A893),
                            ],
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(16.0.r),
                          child: Image.asset(IconPath.filter,height: 24.h,width: 24.w,fit: BoxFit.contain,),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 48.h,),
                QuoteCard(),
                SizedBox(height: 24.h,),
                Container(
                  padding: EdgeInsets.all(16.0.sp),
                  width: 335.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:  EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C3930),
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: Image.asset(
                          IconPath.calender17,height: 24.h , width: 24.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Tu objetivo',
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: 'Desarrollar músculo',
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(width: 24.w),
                    ],
                  ),
                ),
                WeekEntertainmentWidget()
              ],
            ),
          ),
        ),
      )
    );
  }
}


