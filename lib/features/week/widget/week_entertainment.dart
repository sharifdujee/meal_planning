import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../model/week_entainment_model.dart';
import '../provider/week_entertainment_provider.dart';


class WeekEntertainmentWidget extends ConsumerWidget {
  const WeekEntertainmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekDays = ref.watch(weeklyEntertainmentProvider);
    final notifier = ref.read(weeklyEntertainmentProvider.notifier);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entrenamiento',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays
                .map((day) => DayToggleSwitch(
              model: day,
              onToggle: () => notifier.toggleDay(day.date),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// A custom vertical pill switch that looks exactly like the screenshot.
/// "On" (completed) = mint green pill with check circle + number
/// "Active" (today) = bright neon green pill + number (no check)
/// "Off" (upcoming) = dark pill with border + muted number
class DayToggleSwitch extends StatefulWidget {
  final WeekEntainmentModel model;
  final VoidCallback onToggle;

  const DayToggleSwitch({
    super.key,
    required this.model,
    required this.onToggle,
  });

  @override
  State<DayToggleSwitch> createState() => _DayToggleSwitchState();
}

class _DayToggleSwitchState extends State<DayToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _colorBlend;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      value: _isOn ? 1.0 : 0.0,
    );

    _colorBlend = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  bool get _isOn =>
      widget.model.status == DayStatus.completed ||
          widget.model.status == DayStatus.active;

  bool get _isCompleted => widget.model.status == DayStatus.completed;
  bool get _isActive    => widget.model.status == DayStatus.active;

  @override
  void didUpdateWidget(DayToggleSwitch old) {
    super.didUpdateWidget(old);
    if (_isOn) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayLetter =
    DateFormat.E('es').format(widget.model.date)[0].toUpperCase();

    // Track colors
    final Color offColor  = const Color(0xFF161D26);
    final Color onColorCompleted = const Color(0xFF202122);   // muted mint
    final Color onColorActive    = const Color(0xFF1C3930);   // neon green
    final Color onColor = _isActive ? onColorActive : onColorCompleted;

    // Border color (only for off state)
    const Color borderColor = Color(0xFF2FC67A);


    // Pill dimensions
    const double pillW  = 41.0;
    const double pillH  = 80.0;
    const double radius = 21.0;


    // Thumb travel: from bottom center to top center inside pill
    // top position when ON:  (pillH/2 - thumbSize/2) - offset_from_center_up
    return GestureDetector(
      onTap: widget.onToggle,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // The pill switch
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              // Interpolate track color
              final Color trackColor = Color.lerp(offColor, onColor, _colorBlend.value)!;

              // Glow for active neon
              final List<BoxShadow> glow = _isActive && _controller.value > 0.5
                  ? [
                BoxShadow(
                  color: const Color(0xFF1C3930).withValues(alpha: 0.5 * _controller.value),
                  blurRadius: 14,
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: const Color(0xFF1C3930).withValues(alpha: 0.2 * _controller.value),
                  blurRadius: 26,
                  spreadRadius: 7,
                ),
              ]
                  : [];

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // ── Track (pill background) ──
                  Container(
                    width: pillW,
                    height: pillH,
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: _isOn
                          ? null
                          : Border.all(color: borderColor, width: 1.5),
                      boxShadow: glow,
                    ),
                    // Day number always shown at top of pill
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 250),
                              style: TextStyle(
                                color: _isOn ? Colors.black : const Color(0xFF8A9BB0).withValues(alpha: 0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                height: 1.0,
                              ),
                              child: Text(dayLetter),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedOpacity(
                              opacity: _isCompleted ? 1:0,
                              duration: Duration(microseconds: 200),
                            child: Container(
                              height: 32.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C3930),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(21.r),
                              ),
                              child: Center(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  opacity: _isCompleted ? 1.0 : 0.0,
                                  child: Image.asset(
                                    IconPath.dumbbell,
                                    height: 20.h,
                                    width: 20.h,
                                    color: const Color(0xFF469271),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Thumb (circle with check) — slides up when ON ──
                  // Only show thumb for completed state (not active — active has no check)
                  // Removed sliding thumb, icon now fixed at bottom
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

double? lerpDouble(double a, double b, double t) => a + (b - a) * t;