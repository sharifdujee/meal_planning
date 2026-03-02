import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../modal/weekly_progress_data_model.dart';
import '../../provider/weekly_progress_provider.dart';

class WeeklyProgressWidget extends ConsumerWidget {
  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekDays = ref.watch(weeklyProgressProvider);
    final notifier = ref.read(weeklyProgressProvider.notifier);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1419),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tu progreso semanal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 18),
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
  final WeekDayModel model;
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
  late Animation<double> _thumbSlide;    // thumb slides from bottom → top
  late Animation<double> _colorBlend;   // track color blend 0→1

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      value: _isOn ? 1.0 : 0.0,
    );
    _thumbSlide = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
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
    final dayNumber = widget.model.date.day;

    // Track colors
    final Color offColor  = const Color(0xFF161D26);
    final Color onColorCompleted = const Color(0xFF3DDC97);   // muted mint
    final Color onColorActive    = const Color(0xFF00FF88);   // neon green
    final Color onColor = _isActive ? onColorActive : onColorCompleted;

    // Border color (only for off state)
    const Color borderColor = Color(0xFF2B3747);

    // Letter color
    final Color letterColor = _isActive
        ? Colors.white
        : _isCompleted
        ? const Color(0xFFAABBCC)
        : const Color(0xFF8A9BB0);

    // Pill dimensions
    const double pillW  = 42.0;
    const double pillH  = 70.0;
    const double radius = 21.0;

    // Thumb (circle) size
    const double thumbSize = 28.0;

    // Thumb travel: from bottom center to top center inside pill
    // top position when ON:  (pillH/2 - thumbSize/2) - offset_from_center_up
    const double thumbPaddingV = 7.0; // padding from pill edge
    const double thumbTopY     = thumbPaddingV;                          // ON  position (top)
    const double thumbBottomY  = pillH - thumbSize - thumbPaddingV;      // OFF position (bottom)

    return GestureDetector(
      onTap: widget.onToggle,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Day letter
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              color: letterColor,
              fontSize: 12.5,
              fontWeight: _isActive ? FontWeight.w700 : FontWeight.w500,
            ),
            child: Text(dayLetter),
          ),
          const SizedBox(height: 6),

          // The pill switch
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              // Interpolate track color
              final Color trackColor = Color.lerp(offColor, onColor, _colorBlend.value)!;
              final double thumbY = lerpDouble(thumbBottomY, thumbTopY, _thumbSlide.value)!;

              // Glow for active neon
              final List<BoxShadow> glow = _isActive && _controller.value > 0.5
                  ? [
                BoxShadow(
                  color: const Color(0xFF00FF88).withValues(alpha: 0.5 * _controller.value),
                  blurRadius: 14,
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: const Color(0xFF00FF88).withValues(alpha: 0.2 * _controller.value),
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
                    // Day number always shown at bottom of pill
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            color: _isOn ? Colors.black : const Color(0xFF8A9BB0).withValues(alpha: 0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            height: 1.0,
                          ),
                          child: Text('$dayNumber'),
                        ),
                      ),
                    ),
                  ),

                  // ── Thumb (circle with check) — slides up when ON ──
                  // Only show thumb for completed state (not active — active has no check)
                  if (!_isActive)
                    Positioned(
                      left: (pillW - thumbSize) / 2,
                      top: thumbY,
                      child: Opacity(
                        opacity: _isActive ? 0 : _controller.value,
                        child: Container(
                          width: thumbSize,
                          height: thumbSize,
                          decoration: BoxDecoration(
                            // Darker circle inside pill for check badge
                            color: Color.lerp(
                              Colors.transparent,
                              const Color(0xFF28B87A),
                              _thumbSlide.value,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Opacity(
                            opacity: _thumbSlide.value,
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
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