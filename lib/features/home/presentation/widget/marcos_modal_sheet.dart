import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../../provider/marco_provider.dart';

// ── Color tokens ───────────────────────────────────────────
const _kBg         = Color(0xFF10151B);
const _kCardDark   = Color(0xFF15181E);
const _kCardBorder = Color(0xFF252B33);
const _kInfoBg     = Color(0xFF152220);
const _kInfoBorder = Color(0xFF1E3D30);
const _kCalBg      = Color(0xFFFAEDE8);
const _kCalBorder  = Color(0xFFF0C8B8);
const _kCalIconBg  = Color(0xFFF5D5C0);
const _kGreen      = Color(0xFF3DDC84);
const _kRed        = Color(0xFFE84040);
const _kOrange     = Color(0xFFE8A020);
const _kGreenBar   = Color(0xFF3DDC84);
const _kMuted      = Color(0xFF8E95A2);
const _kBarBg      = Color(0xFF252B33);
const _kRedIcon    = Color(0xFFE84040);

class MacrosModalSheet extends ConsumerWidget {
  const MacrosModalSheet({super.key});

  // ── Call this to show the sheet ─────────────────────────
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // ✅ FIX 1: transparent so our Container color shows, no white bg
      backgroundColor: Colors.transparent,
      // ✅ FIX 2: isScrollControlled lets sheet grow taller than 50% height
      isScrollControlled: true,
      // ✅ FIX 3: barrierColor for dark scrim
      barrierColor: Colors.black54,
      builder: (_) => const MacrosModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(macroProvider);

    return ClipRRect(
      // ✅ FIX 4: ClipRRect clips the child to the rounded top corners
      // This eliminates the white corner artifacts
      borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      child: Container(
        color: _kBg,                          // flat color, no borderRadius needed here
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32.h,
          left: 20.w,
          right: 20.w,
        ),
        // ✅ FIX 5: SingleChildScrollView prevents Column overflow
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Drag handle ─────────────────────────────
              Center(
                child: Container(
                  width: 48.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              // ── Header ──────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: _kRedIcon,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child:  Center(
                      child: Image.asset(
                        IconPath.redTarget

                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VALORES ESTIMADOS',
                          style: TextStyle(
                            color: _kGreen,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          data.mealName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // ── Info banner ──────────────────────────────
              Container(
                width: double.infinity,
                padding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _kInfoBg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _kInfoBorder, width: 1.w),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: _kGreen, size: 18.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Basado en tu objetivo diario (25% del total)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 14.h),

              // ── Calories card ────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 14.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: _kCalBg,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: _kCalBorder, width: 1.w),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        color: _kCalIconBg,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.restaurant_rounded,
                          color: _kRed, size: 20.sp),
                    ),
                    SizedBox(width: 14.w),
                    Text(
                      'Calorias',
                      style: TextStyle(
                        color: const Color(0xFF1A1A1A),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '≈',
                      style: TextStyle(
                        color: _kRed,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${data.calories}',
                      style: TextStyle(
                        color: _kRed,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 14.h),

              // ── Macro cards ──────────────────────────────
              _MacroCard(
                icon: IconPath.steak,
                iconColor: const Color(0xFF8A9BB0),
                label: 'Proteina',
                value: '${data.protein}g',
                valueColor: _kRed,
                percent: data.proteinPercent,
                barColor: _kRed,
                percentLabel:
                '${(data.proteinPercent * 100).round()}% del total',
              ),
              SizedBox(height: 10.h),

              _MacroCard(
                icon: IconPath.leaf,
                iconColor: const Color(0xFF8A9BB0),
                label: 'Carbohidratos',
                value: '${data.carbs}g',
                valueColor: _kOrange,
                percent: data.carbsPercent,
                barColor: _kOrange,
                percentLabel:
                '${(data.carbsPercent * 100).round()}% del total',
              ),
              SizedBox(height: 10.h),

              _MacroCard(
                icon: IconPath.droplet,
                iconColor: const Color(0xFF8A9BB0),
                label: 'Grasas',
                value: '${data.fat}g',
                valueColor: _kGreen,
                percent: data.fatPercent,
                barColor: _kGreenBar,
                percentLabel:
                '${(data.fatPercent * 100).round()}% del total',
              ),

              SizedBox(height: 20.h),

              // ── Footer ───────────────────────────────────
              Center(
                child: Text(
                  'Estos valores son aproximados según tus objetivos\nnutricionales diarios.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _kMuted,
                    fontSize: 12.sp,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Single Macro Row Card
// ─────────────────────────────────────────────────────────
class _MacroCard extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;
  final double percent;
  final Color barColor;
  final String percentLabel;

  const _MacroCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.percent,
    required this.barColor,
    required this.percentLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: _kCardDark,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _kCardBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, fit: BoxFit.cover,height: 24.h,width: 24.w,),

              SizedBox(width: 10.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 5.h,
              backgroundColor: _kBarBg,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            percentLabel,
            style: TextStyle(
              color: _kMuted,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}