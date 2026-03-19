
import 'dart:async';
import 'package:flutter/foundation.dart';

@immutable
class SeassionWorkoutLogState {
  final Duration sessionTime;
  final bool isTimerRunning;
  final bool isFinished;
  final bool isActive;

  const SeassionWorkoutLogState({
    this.sessionTime = Duration.zero,
    this.isTimerRunning = false,
    this.isFinished = false,
    this.isActive = false,
  });

  // Helper for updating the state immutably
  SeassionWorkoutLogState copyWith({
    Duration? sessionTime,
    bool? isTimerRunning,
    bool? isFinished,
    bool? isActive,
  }) {
    return SeassionWorkoutLogState(
      sessionTime: sessionTime ?? this.sessionTime,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      isFinished: isFinished ?? this.isFinished,
      isActive: isActive ?? this.isActive,
    );
  }
}