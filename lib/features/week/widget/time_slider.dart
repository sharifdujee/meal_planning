import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../provider/duration_provider.dart';

class TimeSlider extends ConsumerWidget {
  const TimeSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(durationProvider);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(

        activeTrackColor: const Color(0xFF6BC799),
        inactiveTrackColor: const Color(0xFF1E2229),
        thumbColor: const Color(0xFF10151B),
        overlayColor: const Color(0xFF5DB08E).withValues(alpha: 0.2),
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 8.sp,
          elevation: 2,
          pressedElevation: 4
        ),
      ),
      child: Slider(
        value: duration,
        min: 15,
        max: 60,
        divisions: 3,
        onChanged: (val) {
          ref.read(durationProvider.notifier).state = val;
        },
      ),
    );
  }
}