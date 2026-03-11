import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/app_color.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  /// Background
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  /// Text
  final Color textColor;
  final TextStyle? textStyle;

  /// Border
  final Gradient? borderGradient;
  final double borderWidth;
  final double borderRadius;
  final bool isOutlined;

  /// Size
  final double height;
  final double width;

  /// Icons
  final IconData? prefixIcon;   // ✅ ADDED
  final IconData? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.backgroundGradient,
    this.textColor = AppColor.white,
    this.textStyle,
    this.borderGradient,
    this.borderWidth = 1.5,
    this.borderRadius = 40,
    this.height = 58,
    this.width = double.infinity,
    this.isOutlined = false,
    this.prefixIcon, // ✅
    this.suffixIcon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _scale = 1.0;

  void _tapDown(_) => setState(() => _scale = 0.97);
  void _tapUp(_) => setState(() => _scale = 1.0);
  void _tapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    final bg = widget.backgroundGradient ??
        widget.backgroundColor ??
        AppColor.primary;

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: widget.height.h,
          width: widget.width,
          decoration: BoxDecoration(
            gradient: widget.isOutlined ? null : (bg is Gradient ? bg : null),
            color: widget.isOutlined
                ? Colors.transparent
                : (bg is Color ? bg : null),
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            border: widget.isOutlined
                ? Border.all(
              width: widget.borderWidth,
              color: const Color(0xFF3E8E73),
            )
                : null,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.prefixIcon != null) ...[
                  Icon(widget.prefixIcon,
                      size: 20.sp, color: widget.textColor),
                  SizedBox(width: 8.w),
                ],
                Text(
                  widget.text,
                  style: widget.textStyle ??
                      GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: widget.textColor,
                      ),
                ),
                if (widget.suffixIcon != null) ...[
                  SizedBox(width: 8.w),
                  Icon(widget.suffixIcon,
                      size: 20.sp, color: widget.textColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}