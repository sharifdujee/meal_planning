import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/authentication/presentation/screen/profile_set_up.dart';
import 'package:meal_planning/features/registration/provider/classification_provider.dart';

class ClassificationProgressCard extends ConsumerWidget{
  const ClassificationProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(classificationProvider);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1,color: Color(0xFF383A42)),
      ),
      child: Container(
        margin: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(IconPath.lock,height: 24.h,width: 24.h,),
                SizedBox(width: 8.w,),
                CustomText(
                  text: "Progreso de clasificación",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                Spacer(),
                CustomText(
                  text: "${progress.totalPointsDisplay} pts",
                  fontSize: 14.sp,
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 12.h),
              child: Divider(),
            ),
            _buildProgressItem(
              label: "Porcentaje de series registradas",
              progressIcon: IconPath.energy,
              value: "${progress.currentSeries}/${progress.totalSeries} series",
              percent: progress.seriesProgress
            ),
            SizedBox(height: 12.h,),
            _buildProgressItem(
                label: "Tiempo",
                progressIcon: IconPath.clock,
                value: "${progress.currentMinutes}/${progress.totalMinutes} min",
                percent: progress.timeProgress
            ),
            SizedBox(height: 12.h,),
            _buildProgressItem(
                label: "Puntos obtenidos en vivo",
                progressIcon: IconPath.pointRight,
                value: "${progress.currentPoints}/${progress.goalPoints} pts",
                percent: progress.pointProgress
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: progress.pointHints.length,
                itemBuilder: (context, index){
                  return CustomText(
                    text: progress.pointHints[index],
                    fontSize: 12.sp,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildProgressItem({
    required String label,
    required String progressIcon,
    required String value,
    required double percent
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Porcentaje de series registradas",
          color: Color(0xFF6B7280),
        ),
        SizedBox(height: 12.h,),
        Row(
          children: [
            Image.asset(progressIcon,height: 16.h,width: 16.w,color: Color(0xFF6B7280),),
            SizedBox(width: 8.w,),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10.r),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 6.h,
                  backgroundColor: const Color(0xFF232425,),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF469271)
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w,),
            CustomText(
              text: value,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ],
        )
      ],
    );
  }
}