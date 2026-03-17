

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';

// ── Color tokens ─────────────────────────────────────────
const _kBg = Color(0xFF10151B); // sheet bg (dark)
const _kCardBg = Color(0xFF1A2028); // meal card bg
const _kCardBgSelected = Color(0xFF0D1F16); // selected card bg (dark green tint)
const _kIconBg = Color(0xFF1E2D24); // icon square bg
const _kGreen = Color(0xFF3DBD7A); // green accent
const _kGreenBorder = Color(0xFF3DBD7A); // selected card border green
const _kOrangeBorder = Color(0xFFB45309); // "elige lo que sientas" dashed border
const _kOrangeBg = Color(0xFF1C1508); // "elige lo que sientas" card bg
const _kOrangeIcon = Color(0xFF92400E); // star icon bg
const _kOrangeIconFg = Color(0xFFFBBF24); // star icon fg
const _kLabelMuted = Color(0xFF6B7280); // "COMIDA ACTUAL" label
const _kMuted = Color(0xFF8E95A2); // description / tag text
const _kTagBg = Color(0xFF1E2D24); // badge bg (Similar / Más rápido)
const _kDivider = Color(0xFF2A333D); // divider line
const _kKeepBtn = Color(0xFF161C23); // "Mantén esta" button bg
const _kKeepBtnBorder = Color(0xFF2A333D); // "Mantén esta" button border
const _kGreenText = Color(0xFF3DBD7A); // "Adaptarse también es avanzar"

class GenerateResultBottomSheet extends StatefulWidget {
  const GenerateResultBottomSheet({super.key});

  @override
  State<GenerateResultBottomSheet> createState() =>
      _GenerateResultBottomSheetState();
}

class _GenerateResultBottomSheetState
    extends State<GenerateResultBottomSheet> {
  int _selectedIndex = 1; // default: second item selected (like screenshot)

  final List<_MealOption> _options = const [
    _MealOption(
      name: 'Pavo Asado con Verduras',
      description:
      'Pechuga de pavo magra servida con verduras de temporada asadas ricas en fibra.',
      tag: '❤ Similar',
      tagColor: Color(0xFF3DBD7A),
      tagBg: Color(0xFF1E2D24),
    ),
    _MealOption(
      name: 'Tofu Salteado con Brócoli',
      description:
      'Cubos de tofu salteados con una crujiente y nutritiva mezcla de verduras verdes.',
      tag: '⚡ Más rápido',
      tagColor: Color(0xFFBEF264),
      tagBg: Color(0xFF1A2810),
    ),
    _MealOption(
      name: 'Pescado Blanco con Hierbas',
      description:
      'Filetes de pescado blanco tierno con limón servidos sobre espinacas salteadas.',
      tag: '🕐 Sin cocinar',
      tagColor: Color(0xFF93C5FD),
      tagBg: Color(0xFF0F1D2D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ClipRRect(
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
        
                // ── Header row: green icon + title + subtitle ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: _kIconBg,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.nightlight_round,
                          color: _kGreen,
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: _kMuted,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
        
                SizedBox(height: 22.h),
        
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
        
                // ── Current meal card ──────────────────────
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _kCardBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34.w,
                        height: 34.h,
                        decoration: BoxDecoration(
                          color: _kIconBg,
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.nightlight_round,
                            color: _kGreen,
                            size: 17.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Cena ligera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
        
                SizedBox(height: 20.h),
        
                // ── "ALTERNATIVAS INTELIGENTES" label ──────
                Text(
                  'ALTERNATIVAS INTELIGENTES',
                  style: TextStyle(
                    color: _kLabelMuted,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
        
                SizedBox(height: 8.h),
        
                // ── Meal options list ──────────────────────
                ...List.generate(_options.length, (i) {
                  final opt = _options[i];
                  final isSelected = _selectedIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected ? _kCardBgSelected : _kCardBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? _kGreenBorder
                              : Colors.transparent,
                          width: 1.5.w,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 34.w,
                            height: 34.h,
                            decoration: BoxDecoration(
                              color: _kIconBg,
                              borderRadius: BorderRadius.circular(9.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.nightlight_round,
                                color: _kGreen,
                                size: 17.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                       text:  opt.name,
        
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
        
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: opt.tagBg,
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        opt.tag,
                                        style: TextStyle(
                                          color: opt.tagColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  opt.description,
                                  style: TextStyle(
                                    color: _kMuted,
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.check_circle,
                            color: isSelected ? _kGreen : _kMuted.withValues(alpha: 0.35),
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
        
                SizedBox(height: 4.h),
        
                // ── "Elige lo que sientas" dashed card ────
                _DashedBorderContainer(
                  borderColor: _kOrangeBorder,
                  borderRadius: 12.r,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: _kOrangeBg,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: _kOrangeIcon,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              '✦',
                              style: TextStyle(
                                color: _kOrangeIconFg,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Elige lo que sientas',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Hoy el sistema se adapta a ti. Sin culpa.',
                              style: TextStyle(
                                color: _kMuted,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        
                SizedBox(height: 16.h),
        
                // ── "Adaptarse también es avanzar." ────────
                Center(
                  child: Text(
                    'Adaptarse también es avanzar.',
                    style: TextStyle(
                      color: _kGreenText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        
                SizedBox(height: 14.h),
        
                // ── "Mantén esta" button ───────────────────
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: _kKeepBtn,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: _kKeepBtnBorder,
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
        ),
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────
class _MealOption {
  final String name;
  final String description;
  final String tag;
  final Color tagColor;
  final Color tagBg;

  const _MealOption({
    required this.name,
    required this.description,
    required this.tag,
    required this.tagColor,
    required this.tagBg,
  });
}

// ── Dashed border painter ─────────────────────────────────
class _DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderRadius;

  const _DashedBorderContainer({
    required this.child,
    required this.borderColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: borderColor,
        radius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()..addRRect(rRect);
    /*final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + dashWidth).clamp(0, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        distance += dashWidth + dashSpace;
      }
    }*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}