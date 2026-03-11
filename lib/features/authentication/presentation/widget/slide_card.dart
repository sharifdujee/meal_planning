import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/design_system/app_color.dart';



class SliderCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final double min;
  final double max;
  final double sliderValue;
  final ValueChanged<double> onChanged;

  const SliderCard({super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: GoogleFonts.dmSans(
                      color: AppColor.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value,
                      style: GoogleFonts.dmMono(
                          color: AppColor.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  Text(unit,
                      style: GoogleFonts.dmSans(
                          color: AppColor.textSecondary, fontSize: 13)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              activeTrackColor: AppColor.accent,
              inactiveTrackColor: AppColor.cardBorder,
              thumbColor: AppColor.accent,
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: sliderValue.clamp(min, max),
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(min.round().toString(),
                  style: GoogleFonts.dmSans(
                      color: AppColor.textMuted, fontSize: 11)),
              Text(max.round().toString(),
                  style: GoogleFonts.dmSans(
                      color: AppColor.textMuted, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }
}