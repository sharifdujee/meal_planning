import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/features/week/provider/select_plan_notifier.dart';

import '../../../core/utils/icon_path.dart';
import '../model/week_plan_model.dart';

class PlanSeletionPopup extends ConsumerWidget {
  const PlanSeletionPopup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectPlanProvider);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFF10151B),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Color(0xFF2FC67A).withValues(alpha: 0.20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: "Planifica tu semana",
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Para ajustar el plan a tu semana real",
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16.h),
            Container(
              width: 48.w,
              height: 48.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF469271), Color(0xFF49A893)],
                ),
              ),
              child: Center(
                child: Image.asset(
                  IconPath.clock,
                  height: 24.h,
                  width: 24.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: "¿Cómo va esta semana?",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Está bien reducir la velocidad",
              fontSize: 14.sp,
              color: Color(0xFF6B7280),
            ),
            SizedBox(height: 24.h,),
            ..._getOptions().map(
              (option) => _buildOptionCard(ref, option, selectedType),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildGestureButton(
                    "Atrás",
                    isPrimary: false,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGestureButton(
                    "Generar plan",
                    isPrimary: true,
                    onPressed: () {
                      // Access the final result:
                      final result = ref.read(selectPlanProvider);
                      print("Generating plan for: $result");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    WidgetRef ref,
    WeekPlanModel option,
    WeekType currentSelection,
  ) {
    final isSelected = option.type == currentSelection;

    return GestureDetector(
      onTap: () => ref.read(selectPlanProvider.notifier).setPlan(option.type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF200012).withValues(alpha: 0.1333),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF5DB08E) : Color(0xFF383A42),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(

              padding: EdgeInsetsGeometry.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFF1C3930),
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                child: Image.asset(option.Icon,height: 20,width: 20,)
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: option.title,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  CustomText(
                    text: option.description,
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_outline, color: Color(0xFF5DB08E)),
          ],
        ),
      ),
    );
  }

  Widget _buildGestureButton(
    String text, {
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF49A893) : const Color(0xFF10151B),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(width: 1.w,color: Color(0xFF469271).withValues(alpha: 0.2))
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

List<WeekPlanModel> _getOptions() {
  return [
    WeekPlanModel(
      type: WeekType.normal,
      title: "Semana normal",
      description: "Plan completo como siempre.",
      Icon: IconPath.batteryEmpty,
    ),
    WeekPlanModel(
      type: WeekType.complicated,
      title: "Semana complicada",
      description: "Menos exigente, mismos resultados.",
      Icon: IconPath.batteryCharging,
    ),
    WeekPlanModel(
      type: WeekType.minimal,
      title: "Semana mínima",
      description: "Lo suficiente para seguir adelante.",
      Icon: IconPath.batteryEmpty2,
    ),
  ];
}
