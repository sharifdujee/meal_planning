import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/classification_progress.dart';

class ClassificationNotifier extends StateNotifier<ClassificationProgress> {
  // Store timers so we can cancel them when the notifier is destroyed
  Timer? _seriesTimer;
  Timer? _minutesTimer;

  ClassificationNotifier() : super(ClassificationProgress(
    currentSeries: 1,
    totalSeries: 8,
    currentMinutes: 12,
    totalMinutes: 60,
    currentPoints: 10,
    goalPoints: 100,
    pointHints: [
      "Completa el entrenamiento para ganar puntos de clasificación (+2 base)"
    ],
  )) {
    _startLiveUpdates();
  }

  void _startLiveUpdates() {
    // 🔄 Updates EVERY 10 seconds
    _seriesTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        state = state.copyWith(
          currentSeries: (state.currentSeries + 1).clamp(0, state.totalSeries),
          currentPoints: state.currentPoints + 2,
        );
      }
    });

    // 🔄 Updates EVERY 15 seconds
    _minutesTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted) {
        state = state.copyWith(
          currentMinutes: (state.currentMinutes + 1).clamp(0, state.totalMinutes),
          currentPoints: state.currentPoints + 5,
        );
      }
    });
  }

  @override
  void dispose() {
    // Always cancel timers to prevent memory leaks and background processing
    _seriesTimer?.cancel();
    _minutesTimer?.cancel();
    super.dispose();
  }
}

final classificationProvider = StateNotifierProvider<ClassificationNotifier, ClassificationProgress>((ref) {
  return ClassificationNotifier();
});