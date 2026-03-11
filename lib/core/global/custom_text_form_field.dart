import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design_system/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool readonly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final int maxLines;
  final Color? containerColor;
  final Color? hintTextColor;
  final double? hintTextSize;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final String? Function(String?)? validator;
  final double? borderRadius;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIconPath,
    this.prefixIcon,
    this.onChanged,
    this.readonly = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.maxLines = 1,
    this.containerColor,
    this.hintTextColor = AppColor.profileTextColor,
    this.hintTextSize = 15,
    this.suffixText,
    this.suffixTextStyle,
    this.validator,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Use provided containerColor, fallback to dark color for dark mode
    final fillColor = containerColor ?? const Color(0xFF111827);

    return TextFormField(
      controller: controller,
      readOnly: readonly,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,

        prefixIcon: prefixIcon ??
            (prefixIconPath != null
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Image.asset(
                prefixIconPath!,
                height: 24.h,
                width: 24.w,
              ),
            )
                : null),

        suffixIcon: suffixIcon,
        suffixText: suffixText,
        suffixStyle: suffixTextStyle ??
            GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
            ),

        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: hintTextSize?.sp ?? 14.sp,
          fontWeight: FontWeight.w400,
          color: hintTextColor,
        ),

        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ),

        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
              borderSide: const BorderSide(color: Color(0xFF1F2937)),
            ),

        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
              borderSide: const BorderSide(color: Color(0xFF1F2937)),
            ),

        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
              borderSide: const BorderSide(color: Color(0xFF38755A)),
            ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(color: AppColor.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(color: AppColor.error),
        ),
      ),
    );
  }
}