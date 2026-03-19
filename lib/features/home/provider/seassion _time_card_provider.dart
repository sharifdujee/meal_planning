import 'dart:async'; // <--- USE THIS FOR TIMER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../modal/WorkoutLogState.dart';

class SeassionWorkoutLogNotifier extends StateNotifier<SeassionWorkoutLogState> {
  SeassionWorkoutLogNotifier() : super(const SeassionWorkoutLogState());

  Timer? _timer;

  void activate(){
    state=state.copyWith(isActive: true);
  }
  void startTimer() {
    if (state.isTimerRunning) return;

    // Reset finished state if starting again
    state = state.copyWith(isTimerRunning: true, isFinished: false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        sessionTime: state.sessionTime + const Duration(seconds: 1),
      );
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  void finishWorkout() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false, isFinished: true);
  }

  void rebootTimer() {
    _timer?.cancel();
    state = const SeassionWorkoutLogState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final seassionWorkoutLogProvider = StateNotifierProvider<SeassionWorkoutLogNotifier, SeassionWorkoutLogState>((ref) {
  return SeassionWorkoutLogNotifier();
});