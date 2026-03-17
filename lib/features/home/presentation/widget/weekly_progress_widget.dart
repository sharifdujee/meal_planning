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

/// Custom vertical pill switch
/// "On" (completed) = mint green with check
/// "Active" (today) = neon green pill
/// "Off" (upcoming) = dark pill
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
  late Animation<double> _thumbSlide;
  late Animation<double> _colorBlend;

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
  bool get _isActive => widget.model.status == DayStatus.active;

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
    // Map weekday numbers to letters (Wednesday = X)
    final Map<int, String> weekdayLetters = {
      1: 'L', // lunes
      2: 'M', // martes
      3: 'X', // miércoles
      4: 'J', // jueves
      5: 'V', // viernes
      6: 'S', // sábado
      7: 'D', // domingo
    };
    final int weekday = widget.model.date.weekday; // 1 = Monday, 7 = Sunday
    final dayLetter = weekdayLetters[weekday]!;

    final dayNumber = widget.model.date.day;

    // Track colors
    final Color offColor = const Color(0xFF161D26);
    final Color onColorCompleted = const Color(0xFF3DDC97); // mint
    final Color onColorActive = const Color(0xFF00FF88); // neon
    final Color onColor = _isActive ? onColorActive : onColorCompleted;

    const Color borderColor = Color(0xFF2B3747);

    final Color letterColor = _isActive
        ? Colors.white
        : _isCompleted
        ? const Color(0xFFAABBCC)
        : const Color(0xFF8A9BB0);

    const double pillW = 40.0;
    const double pillH = 70.0;
    const double radius = 21.0;
    const double thumbSize = 28.0;
    const double thumbPaddingV = 7.0;
    const double thumbTopY = thumbPaddingV;
    const double thumbBottomY = pillH - thumbSize - thumbPaddingV;

    return GestureDetector(
      onTap: widget.onToggle,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final Color trackColor =
              Color.lerp(offColor, onColor, _colorBlend.value)!;
              final double thumbY =
              lerpDouble(thumbBottomY, thumbTopY, _thumbSlide.value)!;

              final List<BoxShadow> glow = _isActive && _controller.value > 0.5
                  ? [
                BoxShadow(
                  color: const Color(0xFF00FF88)
                      .withOpacity(0.5 * _controller.value),
                  blurRadius: 14,
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: const Color(0xFF00FF88)
                      .withOpacity(0.2 * _controller.value),
                  blurRadius: 26,
                  spreadRadius: 7,
                ),
              ]
                  : [];

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Pill track
                  Container(
                    width: pillW,
                    height: pillH,
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: _isOn ? null : Border.all(color: borderColor, width: 1.5),
                      boxShadow: glow,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            color: _isOn
                                ? Colors.black
                                : const Color(0xFF8A9BB0).withOpacity(0.6),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            height: 1.0,
                          ),
                          child: Text('$dayNumber'),
                        ),
                      ),
                    ),
                  ),

                  // Thumb for completed
                  if (!_isActive)
                    Positioned(
                      left: (pillW - thumbSize) / 2,
                      top: thumbY,
                      child: Opacity(
                        opacity: _controller.value,
                        child: Container(
                          width: thumbSize,
                          height: thumbSize,
                          decoration: BoxDecoration(
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