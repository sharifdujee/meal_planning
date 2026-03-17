import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/registration/model/classification_progress.dart';

final classificationProvider = StateProvider<ClassificationProgress>((ref){
  return ClassificationProgress(
      currentSeries: 1,
      totalSeries: 8,
      currentMinutes: 12,
      totalMinutes: 60,
      currentPoints: 10,
      goalPoints: 100,
      totalPointsDisplay: 0,
    pointHints: ["Completa el entrenamiento para ganar puntos de clasificación (+2 base)"],
  );
});