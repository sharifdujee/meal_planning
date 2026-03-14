import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ─── Colors ───────────────────────────────────────────────
const kBg          = Color(0xFF0F1510);   // deepest background
const kCardBg      = Color(0xFF1A2B1F);   // series card background
const kCardDone    = Color(0xFF1E3226);   // completed series card (slightly lighter)
const kChipBg      = Color(0xFF1E3226);   // small chips
const kInputBg     = Color(0xFF1E3226);   // number input fields
const kGreen       = Color(0xFF3DDC84);   // primary green (check, labels)
const kGreenBright = Color(0xFF00FF88);   // neon accent (unused here but defined)
const kBorder      = Color(0xFF2A4035);   // card border
const kMuted       = Color(0xFF6B8F72);   // muted text
const kTimerBg     = Color(0xFF162219);   // timer row background

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  // Series state
  final List<bool> _completed = [true, false, false, false];
  final List<int>  _weights   = [41, 41, 41, 41];
  final List<String> _reps    = ['6-10', '6-10', '6-10', '6-10'];

  // Timer state (shown under completed series)
  bool  _timerRunning = true;
  int   _timerSeconds = 61; // 1:01
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timerRunning && _timerSeconds > 0) {
        setState(() => _timerSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerDisplay {
    final m = _timerSeconds ~/ 60;
    final s = _timerSeconds % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  // Total rest time for progress (90 seconds assumed)
  double get _timerProgress => 1 - (_timerSeconds / 90).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Color(0xFF202122),
        border: Border.all(
          width: 1.w,
          color: Color(0xFF383A42), 
        )
      ),
      child: SafeArea(
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header row ────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Expanded(
                      child: Text(
                        'Dominadas\no  Jalón al\npecho',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Buttons column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Cambiar button
                        _OutlineButton(
                          icon: Icons.refresh_rounded,
                          label: 'Cambiar',
                          onTap: () {},
                        ),
                        const SizedBox(height: 8),
                        // 0/4 × 6-10 chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: kChipBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kBorder, width: 1),
                          ),
                          child: const Text(
                            '0/4 × 6-10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ── Última vez row ────────────────────────────
                Row(
                  children: [
                    const Text(
                      'Última vez:',
                      style: TextStyle(
                        color: kGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: List.generate(4, (i) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: kChipBg,
                              borderRadius: BorderRadius.circular(8),
                              border:
                              Border.all(color: kBorder, width: 1),
                            ),
                            child: Text(
                              'S${i + 1}: 41kg',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Series list ───────────────────────────────
                ...List.generate(4, (i) {
                  final isDone = _completed[i];
                  final isFirst = i == 0;

                  return Column(
                    children: [
                      // Series row card
                      GestureDetector(
                        onTap: () =>
                            setState(() => _completed[i] = !_completed[i]),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 13),
                          decoration: BoxDecoration(
                            color: isDone ? kCardDone : kCardBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDone
                                  ? kGreen.withValues(alpha: 0.25)
                                  : kBorder,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Check circle
                              _CheckCircle(checked: isDone),
                              SizedBox(width: 4.w),

                              // Serie label
                              Text(
                                'Serie ${i + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const Spacer(),

                              // Weight input
                              _NumberBox(value: '${_weights[i]}'),
                              const SizedBox(width: 6),
                              const Text(
                                'Kg',
                                style: TextStyle(
                                  color: kMuted,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Reps input
                              _NumberBox(value: _reps[i]),
                              const SizedBox(width: 6),
                              Text(
                                '/${_reps[i]}',
                                style: const TextStyle(
                                  color: kMuted,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Timer panel — only after first completed serie
                      if (isFirst && isDone) ...[
                        const SizedBox(height: 2),
                        _TimerPanel(
                          display: _timerDisplay,
                          progress: _timerProgress,
                          isRunning: _timerRunning,
                          onPause: () =>
                              setState(() => _timerRunning = !_timerRunning),
                          onReset: () =>
                              setState(() => _timerSeconds = 90),
                          onClose: () =>
                              setState(() => _completed[0] = false),
                        ),
                      ],

                      const SizedBox(height: 8),
                    ],
                  );
                }),
              ],
            ),


      ),
    );
  }
}

// ─── Timer panel (expanded below Serie 1) ────────────────
class _TimerPanel extends StatelessWidget {
  final String display;
  final double progress;
  final bool isRunning;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onClose;

  const _TimerPanel({
    required this.display,
    required this.progress,
    required this.isRunning,
    required this.onPause,
    required this.onReset,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTimerBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(0)),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: kBorder,
              valueColor:
              const AlwaysStoppedAnimation<Color>(kGreen),
              minHeight: 3,
            ),
          ),

          // Timer row
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Time display
                Text(
                  display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                // Bell icon
                const Icon(Icons.alarm_rounded,
                    color: kMuted, size: 18),

                const Spacer(),

                // Pause
                GestureDetector(
                  onTap: onPause,
                  child: Icon(
                    isRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: kMuted,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 18),
                // Reset
                GestureDetector(
                  onTap: onReset,
                  child: const Icon(Icons.refresh_rounded,
                      color: kMuted, size: 22),
                ),
                const SizedBox(width: 18),
                // Close
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(Icons.close_rounded,
                      color: kMuted, size: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Check / uncheck circle ──────────────────────────────
class _CheckCircle extends StatelessWidget {
  final bool checked;
  const _CheckCircle({required this.checked});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? Colors.transparent : Colors.transparent,
        border: Border.all(
          color: checked ? kGreen : const Color(0xFF3A5545),
          width: checked ? 2.2 : 1.8,
        ),
      ),
      child: checked
          ? const Icon(Icons.check_rounded,
          color: kGreen, size: 18)
          : null,
    );
  }
}

// ─── Number input box ─────────────────────────────────────
class _NumberBox extends StatelessWidget {
  final String value;
  const _NumberBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 44),
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: kInputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─── Outline pill button (Cambiar) ────────────────────────
class _OutlineButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: kChipBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorder, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: kGreen, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}