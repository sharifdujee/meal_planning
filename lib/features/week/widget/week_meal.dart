import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/widget/meal_card.dart';

import '../provider/week_meal_provider.dart';

class WeekMeal extends ConsumerWidget {
  const WeekMeal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(currentDayPlanProvider);

    final expandedDay = ref.watch(expandedDayProvider);
    final isExpanded = expandedDay == plan.dayName;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
      decoration: isExpanded ? BoxDecoration(
        color: Color(0xFF6BC799).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: Color(0xFF383A42),
        ),
      ) : BoxDecoration(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ref.read(expandedDayProvider.notifier).state = isExpanded
                  ? null
                  : plan.dayName;
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CustomText(text: plan.dayName,fontSize: 16,),
                  const SizedBox(width: 8),
                  if (plan.isConfirmed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BC799).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const CustomText(text: "Confirmado",color: Color(0xFF82D361),fontSize: 12,),
                    ),
                  const Spacer(),
                  Image.asset(isExpanded ? IconPath.arrowUp : IconPath.arrowDown,height: 24.h,width: 24.h,),
                ],
              ),
            ),
          ),
          // 3. Show meals only if expanded
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: plan.meals.map((meal) {
                  return ProviderScope(
                    overrides: [currentMealProvider.overrideWithValue(meal)],
                    child: const MealCard(),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
