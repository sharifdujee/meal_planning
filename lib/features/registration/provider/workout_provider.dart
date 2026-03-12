import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/registration/model/workout_set.dart';

class WorkoutNotifier extends StateNotifier<List<WorkoutExercise>> {
  WorkoutNotifier() : super([]);

  void toggleEdit(String id) {
    // We update the state by mapping through the list
    state = [
      for (final ex in state)
        if (ex.id == id)
          ex.copyWith(isEditing: !ex.isEditing)
        else
        // This ensures only ONE exercise is open at a time
          ex.copyWith(isEditing: false)
    ];
  }

  void addExercise() {
    final newExercise = WorkoutExercise(
        name: "",
        restTimeInMinutes: 1,
        sets: [],
        isEditing: true
    );
    // When adding, we close all others and add the new one as "editing"
    state = [
      for (final ex in state) ex.copyWith(isEditing: false),
      newExercise
    ];
  }

  void addSetToExercise(String exerciseId) {
    state = [
      for (final ex in state)
        if (ex.id == exerciseId)
          ex.copyWith(sets: [...ex.sets, WorkoutSet(reps: 0, weight: 0)])
        else
          ex
    ];
  }
}

final workoutProvider = StateNotifierProvider<WorkoutNotifier, List<WorkoutExercise>>((ref) {
  return WorkoutNotifier();
});