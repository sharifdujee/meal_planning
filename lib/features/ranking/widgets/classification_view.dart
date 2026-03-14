import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/design_system/app_color.dart';
import '../model/ranking_page State.dart';

class ClassificationView extends ConsumerWidget {
  final RankingPageState state;

  const ClassificationView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          CustomText(
            text: "Estadísticas Globales",
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: "Aquí verás el progreso de las ligas globales.",
            color: AppColor.textBody,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}