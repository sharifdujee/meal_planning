/* import 'dart:async';
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
      setState(() => _totalTimerRunning = false);
    } else {
      _totalTimerRunning = true;
      _totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => _totalWorkoutSeconds++);
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Logic: Local timers only run if the Main Workout Timer is active
      if (!_totalTimerRunning || !_timerRunning) return;

      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        _timer?.cancel();
        if (_isResting) {
          setState(() {
            _isResting = false;
            _timerRunning = false;
            if (_activeSeriesIndex < _completed.length - 1) {
              _activeSeriesIndex++;
            }
          });
        } else {
          setState(() {
            _isResting = true;
            _timerSeconds = _restGapSeconds; // 120s
            _timerRunning = true;
          });
          _startTimer();
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
                // Inside build() -> Column -> Header row
                _OutlineButton(
                  icon: _totalTimerRunning ? Icons.pause : Icons.play_arrow,
                  label: _totalWorkoutSeconds == 0
                      ? "comenzar el entrenamiento"
                      : "Tiempo: ${_formatDuration(_totalWorkoutSeconds)}", // Updated label
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

 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/home/presentation/widget/time_panel.dart';

// ─── Colors (original dark theme — unchanged) ─────────────
const kBg = Color(0xFF0F1510);
const kCardBg = Color(0xFF1A2B1F);
const kCardDone = Color(0xFF1E3226);
const kChipBg = Color(0xFF1E3226);
const kInputBg = Color(0xFF1E3226);
const kGreen = Color(0xFF3DDC84);
const kGreenBright = Color(0xFF00FF88);
const kBorder = Color(0xFF2A4035);
const kMuted = Color(0xFF6B8F72);
const kTimerBg = Color(0xFF162219);

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  // ── Series state ──────────────────────────────────────────
  final List<bool> _completed = [false, false, false, false];
  final List<int> _weights = [41, 41, 41, 41];
  final List<String> _reps = ['6-10', '6-10', '6-10', '6-10'];
  int _activeSeriesIndex = 0;

  // ── Per-set timer ─────────────────────────────────────────
  bool _timerRunning = false;
  int _timerSeconds = 0;
  Timer? _timer;
  bool _isResting = false;

  // ── Total workout timer ───────────────────────────────────
  bool _totalTimerRunning = false;
  int _totalWorkoutSeconds = 0;
  Timer? _totalTimer;
  bool _workoutStarted = false;

  // Config
  final int _restGapSeconds = 120;
  final int _estimatedSetSeconds = 90;

  // ── Timer controls ────────────────────────────────────────
  void _startWorkout() {
    setState(() => _workoutStarted = true);
    _resumeWorkoutTimer();
  }

  void _resumeWorkoutTimer() {
    if (_totalTimerRunning) return;
    setState(() => _totalTimerRunning = true);
    _totalTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _totalWorkoutSeconds++);
    });
  }

  void _pauseWorkoutTimer() {
    _totalTimer?.cancel();
    setState(() => _totalTimerRunning = false);
  }

  void _cancelWorkout() {
    _totalTimer?.cancel();
    _timer?.cancel();
    setState(() {
      _workoutStarted = false;
      _totalTimerRunning = false;
      _totalWorkoutSeconds = 0;
      _timerRunning = false;
      _timerSeconds = 0;
      _isResting = false;
      _activeSeriesIndex = 0;
      for (int i = 0; i < _completed.length; i++) _completed[i] = false;
    });
  }

  void _finalizeWorkout() {
    // TODO: persist & navigate
    _cancelWorkout();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_totalTimerRunning || !_timerRunning) return;
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        _timer?.cancel();
        if (_isResting) {
          setState(() {
            _isResting = false;
            _timerRunning = false;
            if (_activeSeriesIndex < _completed.length - 1) {
              _activeSeriesIndex++;
            }
          });
        } else {
          setState(() {
            _isResting = true;
            _timerSeconds = _restGapSeconds;
            _timerRunning = true;
          });
          _startTimer();
        }
      }
    });
  }

  // ── Helpers ───────────────────────────────────────────────
  String _formatDuration(int s) {
    final m = s ~/ 60;
    final sec = s % 60;
    return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  String get _timerDisplay {
    final m = _timerSeconds ~/ 60;
    final s = _timerSeconds % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _timerProgress => 1 - (_timerSeconds / 90).clamp(0.0, 1.0);

  int get _completedCount => _completed.where((c) => c).length;

  @override
  void dispose() {
    _timer?.cancel();
    _totalTimer?.cancel();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: const Color(0xFF161718),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 1.w, color: const Color(0xFF2A2C30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWorkoutHeaderCard(),
          if (_workoutStarted) ...[
            SizedBox(height: 10.h),
            _buildProgresoRankingCard(),
          ],
          SizedBox(height: 10.h),
          _buildExerciseCard(),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // SECTION 1 — Workout header card
  // ══════════════════════════════════════════════════════════
  Widget _buildWorkoutHeaderCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: const Color(0xFF383A42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row: icon + title/subtitle + timer badge
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: kGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: kBorder, width: 1),
                ),
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: kGreen,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tu tarea de hoy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Entrenamiento del día',
                      style: TextStyle(color: kMuted, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              // Timer badge (top-right)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: kChipBg,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: kBorder, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined, color: kGreen, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDuration(_totalWorkoutSeconds),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // ── Not started: single Empezar button ────────────
          if (!_workoutStarted)
            _OutlineButton(
              icon: Icons.play_arrow_rounded,
              label: 'Empezar entrenamiento',
              onTap: _startWorkout,
            )
          // ── Started: timer row + Finalizar ────────────────
          else ...[
            // Row: elapsed | Pausar | Cancelar
            Row(
              children: [
                // Elapsed badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: kChipBg,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: kBorder, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer_outlined, color: kGreen, size: 13.sp),
                      SizedBox(width: 5.w),
                      Text(
                        _formatDuration(_totalWorkoutSeconds),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // Pausar / Reanudar — outlined pill (like screenshot)
                Expanded(
                  child: GestureDetector(
                    onTap: _totalTimerRunning
                        ? _pauseWorkoutTimer
                        : _resumeWorkoutTimer,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(color: kBorder, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _totalTimerRunning
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _totalTimerRunning ? 'Pausar' : 'Reanudar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                // Cancelar — filled red pill (like screenshot)
                GestureDetector(
                  onTap: _cancelWorkout,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB03A3A),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            // Finalizar entrenamiento — full-width green
            GestureDetector(
              onTap: _finalizeWorkout,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A7D5E),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Finalizar entrenamiento',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // SECTION 2 — Progreso ranking card
  // ══════════════════════════════════════════════════════════
  Widget _buildProgresoRankingCard() {
    final minutesDone = (_totalWorkoutSeconds / 60).clamp(0.0, 60.0);
    final setsProgress = (_completedCount / 20).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: const Color(0xFF383A42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Icon(Icons.emoji_events_outlined, color: kMuted, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Progreso ranking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kChipBg,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: kBorder, width: 1),
                ),
                child: Text(
                  '~10 pts',
                  style: TextStyle(
                    color: kGreen,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Time row
          _RankingRow(
            icon: Icons.timer_outlined,
            value: minutesDone / 60,
            label: '${minutesDone.toInt()}/60 min',
          ),
          SizedBox(height: 6.h),

          // Sets row
          _RankingRow(
            icon: Icons.radio_button_checked_outlined,
            value: setsProgress,
            label: '$_completedCount/20',
          ),
          SizedBox(height: 6.h),

          // Weight row (placeholder)
          _RankingRow(
            icon: Icons.fitness_center_outlined,
            value: 0,
            label: '0/20',
          ),

          SizedBox(height: 8.h),

          Text(
            'Completa el entrenamiento para sumar al ranking (+10 base)',
            style: TextStyle(color: kMuted, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // SECTION 3 — Exercise card (original dark style)
  // ══════════════════════════════════════════════════════════
  Widget _buildExerciseCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0xFF202122),
        border: Border.all(width: 1.w, color: const Color(0xFF383A42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // Title row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _OutlineButton(
                    icon: Icons.refresh_rounded,
                    label: 'Cambiar',
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: kChipBg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kBorder, width: 1),
                    ),
                    child: Text(
                      '$_completedCount/4 × 6-10',
                      style: const TextStyle(
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

          // Última vez row
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
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: kChipBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kBorder, width: 1),
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

          // Series list
          ...List.generate(4, (i) {
            final isDone = _completed[i];
            final isActive = i == _activeSeriesIndex;

            return Column(
              children: [
                GestureDetector(
                  onTap: () => _onSeriesTap(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: isDone
                          ? kCardDone
                          : (_timerRunning && !isActive)
                          ? kCardBg.withOpacity(0.5)
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
                        _CheckCircle(checked: isDone),
                        SizedBox(width: 4.w),
                        Text(
                          'Serie ${i + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
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

                // Timer panel below active completed series
                if (isActive && isDone) ...[
                  const SizedBox(height: 2),
                  TimerPanel(
                    display: _timerDisplay,
                    progress: _timerProgress,
                    isRunning: _timerRunning,
                    onPause: () =>
                        setState(() => _timerRunning = !_timerRunning),
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
    );
  }

  // ── Series tap ────────────────────────────────────────────
  void _onSeriesTap(int i) {
    final bool isDifferentSeries = i != _activeSeriesIndex;

    if (_timerRunning && !_isResting && isDifferentSeries) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2C3E33).withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: kGreen.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: kGreen, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Termina la serie actual antes de marcar otra',
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
        // Auto-start workout if not already started
        if (!_workoutStarted) {
          _workoutStarted = true;
          _resumeWorkoutTimer();
        }
        _activeSeriesIndex = i;
        _timerSeconds = _estimatedSetSeconds;
        _timerRunning = true;
        _isResting = false;
        _startTimer();
      } else {
        if (i == _activeSeriesIndex) {
          _timerRunning = false;
          _timer?.cancel();
        }
      }
    });
  }
}

// ─── Ranking progress row ─────────────────────────────────
class _RankingRow extends StatelessWidget {
  final IconData icon;
  final double value;
  final String label;
  const _RankingRow({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: kMuted),
        SizedBox(width: 8.w),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: kBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(kGreen),
              minHeight: 5,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 52.w,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: TextStyle(color: kMuted, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}

// ─── Check / uncheck circle ───────────────────────────────
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
        color: Colors.transparent,
        border: Border.all(
          color: checked ? kGreen : const Color(0xFF3A5545),
          width: checked ? 2.2 : 1.8,
        ),
      ),
      child: checked
          ? const Icon(Icons.check_rounded, color: kGreen, size: 18)
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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

// ─── Outline pill button ──────────────────────────────────
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
