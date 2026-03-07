import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// ── Color tokens ───────────────────────────────────────────
const _kBg        = Color(0xFF1C2421);
const _kCardInner = Color(0xFF243029);
const _kGreen     = Color(0xFF3DDC84);
const _kGreenDim  = Color(0xFF2A4A35);
const _kMuted     = Color(0xFF7A8F82);
const _kChipBg    = Color(0xFF2A3530);
const _kBorder    = Color(0xFF2F3D35);

class ProteinSupplementCard extends StatelessWidget {
  const ProteinSupplementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Row 1: Title + Opcional chip ──────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Concentrado de Proteína de Suero',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: _kChipBg,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: _kBorder, width: 1.w),
                ),
                child: Text(
                  'Opcional',
                  style: TextStyle(
                    color: _kMuted,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Text(
            'Proteína de Suero. 1000g',
            style: TextStyle(
              color: _kMuted,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'Proteína de alta calidad para tus músculos.',
            style: TextStyle(
              color: _kMuted,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),

          SizedBox(height: 16.h),

          // ── Dosis diaria card ─────────────────────────
          Container(
            decoration: BoxDecoration(
              color: _kCardInner,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _kBorder, width: 1.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tu dosis diaria',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '50g/día',
                      style: TextStyle(
                        color: _kGreen,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // ✅ FIX: width: double.infinity + Expanded text → no overflow
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: _kGreenDim,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.5.h),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: _kGreen,
                          size: 14.sp,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: Text(
                          '1,8g/kg objetivo · 60g dieta = ~50g extra',
                          style: TextStyle(
                            color: _kGreen,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // ── Stats row: 40 días | 1 Compra ─────────────
          Container(
            decoration: BoxDecoration(
              color: _kCardInner,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _kBorder, width: 1.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // 40 días
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          color: _kMuted, size: 18.sp),
                      SizedBox(width: 8.w),
                      // ✅ FIX: Expanded on Column so text doesn't overflow
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '40 días',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'El envase dura',
                              style: TextStyle(
                                color: _kMuted,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Vertical divider
                Container(
                  width: 1.w,
                  height: 32.h,
                  color: _kBorder,
                ),

                // 1 Compra recomendada
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Row(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            color: _kMuted, size: 18.sp),
                        SizedBox(width: 8.w),
                        // ✅ FIX: Expanded on Column so "Compra recomendada" wraps
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Compra recomendada',
                                style: TextStyle(
                                  color: _kMuted,
                                  fontSize: 11.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ── CTA Button ────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                _launcherUrl("https://www.myprotein.es/");
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  color: _kGreen,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Text(
                    'Ver en MyProtein',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// url launcher navigate url
  Future<void> _launcherUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}