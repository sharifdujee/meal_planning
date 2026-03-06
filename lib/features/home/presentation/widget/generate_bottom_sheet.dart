import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'generate_result_bottomn_sheet.dart';

// ── Color tokens ─────────────────────────────────────────
const _kBg         = Color(0xFF10151B);   // sheet bg
const _kIconBg     = Color(0xFF3DBD7A);   // green icon square

const _kFabBg      = Color(0xFF2A7A5A);   // sparkle FAB circle bg (teal)
const _kBtnBorder  = Color(0xFF2A333D);   // "Mantén esta" outline border
const _kLabelMuted = Color(0xFF6B7280);   // "COMIDA ACTUAL" label
const _kMuted      = Color(0xFF8E95A2);   // description text

class GenerateBottomSheet extends StatelessWidget {
  const GenerateBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (_) => const GenerateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      child: Container(
        color: _kBg,
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 28.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag handle ────────────────────────────
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),

            SizedBox(height: 18.h),

            // ── Header row: green icon + title + subtitle
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Green rounded icon box
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: _kIconBg,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.restaurant_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elige otra opción',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Misma intención, comida diferente.',
                      style: TextStyle(
                        color: _kMuted,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // ── "COMIDA ACTUAL" label ──────────────────
            Text(
              'COMIDA ACTUAL',
              style: TextStyle(
                color: _kLabelMuted,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),

            SizedBox(height: 8.h),

            // ── Current meal name ──────────────────────
            Text(
              'Gambas y Quinoa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),

            SizedBox(height: 36.h),

            // ── Sparkle FAB + label ────────────────────
            Center(
              child: Column(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: _kFabBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '✦',          // sparkle / stars character
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Encontrar Alternativa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // ── "Mantén esta" outlined button ──────────
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (context)=>GenerateResultBottomSheet());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _kBtnBorder,
                      width: 1.5.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mantén esta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}