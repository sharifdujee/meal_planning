import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';

class RecoveryTrainingCard extends StatelessWidget {
  const RecoveryTrainingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: CustomPaint(
              painter: DottedBorderPainter(
                color: AppColor.primary,   // full opacity — bright green
                borderRadius: 12.r,
                dashWidth: 8.w,              // visible dash length
                dashSpace: 6.h,              // gap between dashes
                strokeWidth: 3.0,          // thick enough to be clearly visible
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1A14),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    // Green icon container
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C3930),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        IconPath.dumbbell,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16.w),

                    // Texts
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entrena de todos modos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Cuenta como un entrenamiento válido para...',
                            style: TextStyle(
                              color: const Color(0xFF6B7280),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.primary,
                      size: 18.w,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

/// Draws a dashed/dotted rounded rectangle border using CustomPainter.
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const DottedBorderPainter({
    required this.color,
    required this.borderRadius,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(borderRadius),
        ),
      );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? dashWidth : dashSpace;
        if (draw) {
          final extractPath = metric.extractPath(
            distance,
            distance + len,
          );
          canvas.drawPath(extractPath, paint);
        }
        distance += len;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(DottedBorderPainter old) =>
      old.color != color ||
          old.borderRadius != borderRadius ||
          old.dashWidth != dashWidth ||
          old.dashSpace != dashSpace ||
          old.strokeWidth != strokeWidth;
}