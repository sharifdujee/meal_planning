import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/home/presentation/widget/time_panel.dart';


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
  final List<bool> _completed = [false, false, false, false];
  final List<int>  _weights   = [41, 41, 41, 41];
  final List<String> _reps    = ['6-10', '6-10', '6-10', '6-10'];
  int _activeSeriesIndex = 0; // Tracks which series shows the timer

  // Timer state (shown under completed series)
  bool  _timerRunning = false;
  bool _seriesRunning = false;
  int   _timerSeconds = 0;
  Timer? _timer;

  bool _totalTimerRunning = false;
  int _totalWorkoutSeconds = 0;
  Timer? _totalTimer;
  bool _isResting = false;


  // Configuration
  final int _restGapSeconds = 120; // 2 minutes
  final int _estimatedSetSeconds = 90; // 45 seconds per set

  @override
  void initState() {
    super.initState();
    _totalTimer?.cancel(); // Add this

  }

  int _initialTotalSeconds = 0; // Needed for progress calculation

  // Progress for the top bar (0.0 to 1.0)
  double get _totalTimeProgress {
    if (_initialTotalSeconds == 0) return 0.0;
    // Calculation: (Total - Remaining) / Total
    return ((_initialTotalSeconds - _totalWorkoutSeconds) / _initialTotalSeconds).clamp(0.0, 1.0);
  }

  String _formatDuration(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    // padLeft(2, '0') ensures 09:05 instead of 9:5
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  void _toggleWorkoutTimer() {
    if (_totalTimerRunning) {
      _totalTimer?.cancel();
      _timer?.cancel(); // Pause local timer as well
      setState(() => _totalTimerRunning = false);
    } else {
      if (_totalWorkoutSeconds == 0) {
        int totalSetsTime = _completed.length * _estimatedSetSeconds;
        int totalRestTime = (_completed.length - 1) * _restGapSeconds;
        _initialTotalSeconds = totalSetsTime + totalRestTime;
        _totalWorkoutSeconds = _initialTotalSeconds;
      }

      _totalTimerRunning = true;
      _totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_totalWorkoutSeconds > 0) {
          setState(() => _totalWorkoutSeconds--);
        } else {
          timer.cancel();
          setState(() => _totalTimerRunning = false);
        }
      });

      _startTimer(); // Ensure the local rest timer starts/resumes
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_totalTimerRunning || !_timerRunning) return;

      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        // ⏱ TIMER FINISHED
        _timer?.cancel();

        if (_isResting) {
          // ✅ REST → NEXT EXERCISE
          setState(() {
            _isResting = false;
            _timerRunning = false;

            if (_activeSeriesIndex < _completed.length - 1) {
              _activeSeriesIndex++;
            }
          });
        } else {
          // ✅ EXERCISE → START REST
          setState(() {
            _isResting = true;
            _timerSeconds = _restGapSeconds;
            _timerRunning = true;
          });

          _startTimer(); // restart for rest
        }
      }
    });
  }

  void _handleRestCompleted() {
    // Logic for what happens when a rest gap finishes
    // For example, reset to the next 2-minute gap for the next series
    setState(() {
      _timerSeconds = _restGapSeconds;
    });
    _startTimer(); // Restart the ticker
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
      padding: EdgeInsets.symmetric(horizontal :16.r),
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
            // Inside build()
            Column(
              children: [
                _OutlineButton(
                  icon: _totalTimerRunning ? Icons.pause : Icons.play_arrow,
                  label: _totalWorkoutSeconds == 0
                      ? "comenzar el entrenamiento"
                      : "Restante: ${_formatDuration(_totalWorkoutSeconds)}",
                  onTap: _toggleWorkoutTimer,
                ),
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    // Use the getter here
                    value: _totalTimeProgress,
                    backgroundColor: kBorder,
                    valueColor: const AlwaysStoppedAnimation<Color>(kGreen),
                    minHeight: 4.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
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
              final isActive = i == _activeSeriesIndex;
              final isFirst = i == 0;

              return Column(
                children: [
                  // Series row card
                  GestureDetector(
                    onTap: () {
                      final bool isDifferentSeries = i != _activeSeriesIndex;

                      if (_timerRunning && !_isResting && isDifferentSeries){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent, // We handle color in the child
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                            content: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                // Transparent dark green/grey
                                color: const Color(0xFF2C3E33).withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: kGreen.withValues(alpha: 0.2),
                                    width: 1
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: kGreen, size: 20.sp),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      "Termina la serie actual antes de marcar otra",
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _completed[i] = !_completed[i];

                        if (_completed[i]) {
                          _activeSeriesIndex = i;

                          _timerSeconds = _estimatedSetSeconds; // 🔥 exercise starts
                          _timerRunning = true;
                          _isResting = false;

                          _startTimer();
                        }else{
                          if (isActive) {
                            _timerRunning = false;
                            _timer?.cancel();
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 13),
                      decoration: BoxDecoration(
                        color: (isDone)
                            ? kCardDone
                            : (_timerRunning && !isActive)
                            ? kCardBg.withOpacity(0.5) // Dimmed
                            : kCardBg,
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
                  if (isActive && isDone) ...[
                    const SizedBox(height: 2),
                    TimerPanel(
                      display: _timerDisplay,
                      progress: _timerProgress,
                      isRunning: _timerRunning,
                      onPause: () => setState(() => _timerRunning = !_timerRunning),
                      onReset: () => setState(() => _timerSeconds = 90),
                      onClose: () => setState(() => _completed[i] = false),
                    ),
                  ],

                  SizedBox(height: 8.h),
                ],
              );
            }),
          ],
        ),


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
        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

