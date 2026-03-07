
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

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
                  margin: EdgeInsets.symmetric(horizontal: 149.w,vertical: 15.h),
                  child: CustomText(
                    text: "Semana",color: Colors.white,textAlign: TextAlign.center,fontSize: 20.sp,
                  ),
                ),
                SizedBox(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1C3930)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                      SizedBox(),
                      Container(
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
                      )
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      )
    );
  }
}
