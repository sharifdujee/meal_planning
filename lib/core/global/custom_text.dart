import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFont {
  inter,
  roboto,
  poppins,
  italiana,
  impact,
}

class CustomText extends StatelessWidget {
  final String text;
  final AppFont font;
  final TextStyle? style;

  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height; // This is now treated as a multiplier in build
  final FontStyle? fontStyle;
  final bool? softWrap;

  const CustomText({
    super.key,
    required this.text,
    this.font = AppFont.inter,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.decoration,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    this.softWrap,
  });

  TextStyle _getFontBase() {
    switch (font) {
      case AppFont.roboto:
        return GoogleFonts.roboto();
      case AppFont.poppins:
        return GoogleFonts.poppins();
      case AppFont.italiana:
        return GoogleFonts.italiana();
      case AppFont.impact:
        return const TextStyle(fontFamily: 'Impact');
      case AppFont.inter:
      default:
        return GoogleFonts.inter();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get the base Google Font style
    TextStyle baseFont = _getFontBase();

    // 2. Combine with the provided AppTextStyle (style)
    // We use copyWith instead of merge to ensure specific properties are handled
    TextStyle combinedStyle = baseFont.merge(style);

    // 3. Apply final manual overrides
    // IMPORTANT: In Flutter, 'height' is a multiplier.
    // If your AppTextStyle height is 24.h and fontSize is 20.sp,
    // the multiplier should be height / fontSize.

    double? finalFontSize = fontSize ?? combinedStyle.fontSize;
    double? finalHeight = height ?? combinedStyle.height;

    // Fix: If height is a large pixel value from ScreenUtil, convert to multiplier
    if (finalHeight != null && finalFontSize != null && finalHeight > 3.0) {
      finalHeight = finalHeight / finalFontSize;
    }

    final TextStyle finalStyle = combinedStyle.copyWith(
      fontSize: finalFontSize,
      fontWeight: fontWeight ?? combinedStyle.fontWeight,
      color: color ?? combinedStyle.color,
      height: finalHeight,
      letterSpacing: letterSpacing ?? combinedStyle.letterSpacing,
      decoration: decoration ?? combinedStyle.decoration,
      fontStyle: fontStyle ?? combinedStyle.fontStyle,
    );

    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: finalStyle,
    );
  }
}