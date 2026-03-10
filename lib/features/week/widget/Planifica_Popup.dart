import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/provider/duration_provider.dart';
import 'package:meal_planning/features/week/widget/plan_seletion_popup.dart';
import 'package:meal_planning/features/week/widget/plan_your_weak_popup.dart';
import 'package:meal_planning/features/week/widget/time_slider.dart';

class PlanificaPopup extends ConsumerWidget{
  const PlanificaPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final duration=ref.watch(durationProvider);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF10151B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF2FC67A).withValues(alpha: 0.20),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(40.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Planifica tu semana",
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 8.h,),
              CustomText(
                text: "Para ajustar el plan a tu semana real",
                fontSize: 14.sp,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.centerLeft,
                    end:  AlignmentGeometry.centerRight,
                    colors: [
                      Color(0xFF469271),
                      Color(0xFF49A893)
                    ]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(IconPath.clock,fit: BoxFit.contain,height: 24.h,width: 24.w,),
                ),
              ),
              SizedBox(height: 16.h,),
              CustomText(
                text: "Es mejor dedicar menos tiempo y seguir adelante que demasiado y fracasar.",
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  CustomText(
                    text: '${duration.toInt()}',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h,),
                  CustomText(
                    text: "minutos",
                    fontSize: 14.sp,
                    color: Color(0xFF6B7280),
                  ),
                ],
              ),
              TimeSlider(),
              SizedBox(height: 15.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "15m",color: Color(0xFF6B7280), fontSize: 14,fontWeight: FontWeight.w400,),
                    CustomText(text: "30m",color: Color(0xFF6B7280), fontSize: 14,fontWeight: FontWeight.w400,),
                    CustomText(text: "45m",color: Color(0xFF6B7280), fontSize: 14,fontWeight: FontWeight.w400,),
                    CustomText(text: "60m",color: Color(0xFF6B7280), fontSize: 14,fontWeight: FontWeight.w400,),
                  ],
                ),
              ),
              SizedBox(height: 32.h,),
              //buttons
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120.w,
                      height: 48.h,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF469271)
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.h,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10151B),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const Text(
                          "Atrás",
                          style: TextStyle(
                            color: Color(0xFF38755A),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.black87,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: PlanSeletionPopup(),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 120.w,
                      height: 48.h,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF469271)
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF469271),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: const Text(
                            "Siguiente",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}