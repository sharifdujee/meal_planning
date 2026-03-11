import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/workout_log.dart';

final workoutLogProvider = NotifierProvider<WorkoutLogNotifier, WorkoutLog>(() {
  return WorkoutLogNotifier();
});

class WorkoutLogNotifier extends Notifier<WorkoutLog> {
  Timer? _timer;

  @override
  WorkoutLog build() {
    ref.onDispose(() => _timer?.cancel());

    return WorkoutLog();
  }

  // START / RESUME
  void startTimer() {
    if (_timer?.isActive ?? false) return;

    state = state.copyWith(isTimerRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        sessionTime: state.sessionTime + const Duration(seconds: 1),
      );
    });
  }

  // PAUSE
  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  // REBOOT (Reset to 0)
  void rebootTimer() {
    _timer?.cancel();
    state = state.copyWith(
      sessionTime: Duration.zero,
      isTimerRunning: false,
    );
  }

  // FINISH
  void finishWorkout() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  void updateName(String name) => state = state.copyWith(workoutName: name);
  void updateNotes(String notes) => state = state.copyWith(notes: notes);
}