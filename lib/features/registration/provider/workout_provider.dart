import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/registration/model/workout_set.dart';

class WorkoutNotifier extends StateNotifier<List<WorkoutExercise>> {
  WorkoutNotifier() : super([]);

  List<WorkoutExercise> _withSequentialIds(List<WorkoutExercise> exercises) {
    return [
      for (var i = 0; i < exercises.length; i++)
        exercises[i].copyWith(id: (i + 1).toString()),
    ];
  }

  void toggleEdit(String id) {
    // We update the state by mapping through the list
    state = [
      for (final ex in state)
        if (ex.id == id)
          ex.copyWith(isEditing: !ex.isEditing,createEditToggle: true)
        else
          // This ensures only ONE exercise is open at a time
          ex.copyWith(isEditing: false,createEditToggle: true),
    ];
  }
  /// Updates specific set data within an exercise
  void updateSetDetails(String exerciseId, String setId, {int? reps, double? weight}) {
    state = [
      for (final ex in state)
        if (ex.id == exerciseId)
          ex.copyWith(
            sets: [
              for (final s in ex.sets)
                if (s.id == setId)
                  s.copyWith(reps: reps, weight: weight)
                else
                  s
            ],
          )
        else
          ex,
    ];
  }

  void addExercise() {
    final newExercise = WorkoutExercise(
      id: (state.length + 1).toString(),
      name: "",
      restTimeInMinutes: 1,
      sets: [],
      isEditing: true,
    );

    // When adding, we close all others and add the new one as "editing"
    state = _withSequentialIds([
      for (final ex in state) ex.copyWith(isEditing: false),
      newExercise,
    ]);
  }

  void addSetToExercise(String exerciseId) {
    state = [
      for (final ex in state)
        if (ex.id == exerciseId)
          ex.copyWith(sets: [...ex.sets, WorkoutSet(reps: 0, weight: 0)])
        else
          ex,
    ];
  }

  /// Adds a new set to the exercise with the given [exerciseId].
  ///
  /// This is a convenience wrapper used by the UI.
  void addSet(String exerciseId) => addSetToExercise(exerciseId);

  /// Updates the name of the exercise.
  void updateExerciseName(String exerciseId, String name) {
    state = [
      for (final ex in state)
        if (ex.id == exerciseId) ex.copyWith(name: name) else ex,
    ];
  }

  /// Updates the rest time for the exercise.
  void updateExerciseRestTime(String exerciseId, int restTime) {
    state = [
      for (final ex in state)
        if (ex.id == exerciseId) ex.copyWith(restTime: restTime) else ex,
    ];
  }

  /// Removes the given [set] from whichever exercise currently contains it.
  ///
  /// This matches the UI call site that only has the [WorkoutSet] instance.
  void deleteSets(WorkoutSet set) {
    state = [
      for (final ex in state)
        if (ex.sets.any((s) => s.id == set.id))
          ex.copyWith(sets: ex.sets.where((s) => s.id != set.id).toList())
        else
          ex,
    ];
  }

  /// Removes the exercise with the given [exerciseId] from the workout.
  void deleteExercise(String exerciseId) {
    state = _withSequentialIds(
      state.where((ex) => ex.id != exerciseId).toList(),
    );
  }
}

final workoutProvider =
    StateNotifierProvider<WorkoutNotifier, List<WorkoutExercise>>((ref) {
      return WorkoutNotifier();
    });
