import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/home/presentation/widget/generate_bottom_sheet.dart';
import 'package:meal_planning/features/home/presentation/widget/marcos_modal_sheet.dart';
import 'package:meal_planning/features/home/presentation/widget/view_recipe_card.dart';

import '../../modal/meal_data_model.dart';
import '../../provider/nutriition_provider.dart';

// ── Color tokens ───────────────────────────────────────────
const kBg         = Color(0xFF141415);
const kCardBg     = Color(0xFF202122);
const kCardBorder = Color(0xFF383A42);
const kGreen      = Color(0xFF3DDC84);
const kGreenDark  = Color(0xFF1E3D2F);
const kMuted      = Color(0xFF8E9099);
const kIconBg     = Color(0xFF1C2B22);

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals        = ref.watch(mealsProvider);
    final supplements  = ref.watch(supplementsProvider);
    final suppNotifier = ref.read(supplementsProvider.notifier);

    // Total items = meals + supplements card + info row
    final int totalItems = meals.length + 2;

    return ListView.builder(
      // ── Critical: lets it size itself inside SingleChildScrollView ──
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // Meal cards
        if (index < meals.length) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _MealCard(meal: meals[index]),
          );
        }

        // Supplements card
        if (index == meals.length) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _SupplementsCard(
              enabled: supplements,
              onToggle: (v) => suppNotifier.state = v,
            ),
          );
        }

        // Info row (last item)
       /* return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, color: kMuted, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'Activado automáticamente según tu objetivo',
                style: TextStyle(color: kMuted, fontSize: 12.sp),
              ),
            ],
          ),
        );*/
      },
    );
  }
}

// ─────────────────────────────────────────────────────────
// Meal Card
// ─────────────────────────────────────────────────────────
class _MealCard extends StatelessWidget {
  final MealModel meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: kCardBorder, width: 1.w),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: icon + category + refresh ──────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal type icon
              Container(
                width: 38.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: kIconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Icon(_mealIcon(meal.type), color: kGreen, size: 20.sp),
                ),
              ),
              SizedBox(width: 12.w),

              // Category + title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.categoryLabel,
                      style: TextStyle(
                        color: kGreen,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      meal.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Refresh icon
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (context)=>GenerateBottomSheet());

                },
                child: Icon(Icons.refresh_rounded, color: kMuted, size: 22.sp),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // ── Description ─────────────────────────────────
          Text(
            meal.description,
            style: TextStyle(color: kMuted, fontSize: 13.sp, height: 1.45),
          ),

          SizedBox(height: 14.h),

          // ── Buttons row ─────────────────────────────────
          Row(
            children: [
              // Ver Receta — green filled
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (context)=>ViewRecipeCard());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book_rounded, color: Colors.black, size: 15.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Ver Receta',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              // Macros — outlined
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (context)=>MacrosModalSheet());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Color(0xFFFAAD14), width: 1.5.w),
                  ),
                  child: Text(
                    'Macros',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _mealIcon(MealType type) {
    switch (type) {
      case MealType.desayuno: return Icons.local_cafe_rounded;
      case MealType.almuerzo: return Icons.restaurant_rounded;
      case MealType.merienda: return Icons.spa_rounded;
      case MealType.cena:     return Icons.nightlight_round;
    }
  }
}

// ─────────────────────────────────────────────────────────
// Supplements Card
// ─────────────────────────────────────────────────────────
class _SupplementsCard extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onToggle;

  const _SupplementsCard({required this.enabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: kCardBorder, width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          // Icon
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: kIconBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(Icons.calendar_today_rounded, color: kGreen, size: 18.sp),
            ),
          ),
          SizedBox(width: 14.w),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suplementos (opcional)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Personalizado según tu peso y objetivo',
                  style: TextStyle(color: kMuted, fontSize: 12.sp),
                ),
              ],
            ),
          ),

          // Toggle switch
          Transform.scale(
            scale: 0.88,
            child: Switch(
              value: enabled,
              onChanged: onToggle,
              activeThumbColor: Colors.white,
              activeTrackColor: kGreen,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: kCardBorder,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}