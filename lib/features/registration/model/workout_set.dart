import 'package:uuid/uuid.dart';

class WorkoutSet {
  final String id;
  final int reps;
  final double weight;

  WorkoutSet({String? id, required this.reps, required this.weight})
    : id = id ?? const Uuid().v4();

  WorkoutSet copyWith({int? reps, double? weight}) => WorkoutSet(
    id: id,
    reps: reps ?? this.reps,
    weight: weight ?? this.weight,
  );
}

class WorkoutExercise {
  final String id;
  final String name;
  final int restTimeInMinutes;
  final List<WorkoutSet> sets;
  final bool isEditing;
  final bool createEditToggle;

  WorkoutExercise({
    String? id,
    required this.name,
    required this.restTimeInMinutes,
    required this.sets,
    this.isEditing = false,
    this.createEditToggle = false,
  }) : id = id ?? const Uuid().v4();

  WorkoutExercise copyWith({
    String? id,
    String? name,
    int? restTime,
    List<WorkoutSet>? sets,
    bool? isEditing,
    createEditToggle,
  }) => WorkoutExercise(
    id: id ?? this.id,
    name: name ?? this.name,
    restTimeInMinutes: restTime ?? restTimeInMinutes,
    sets: sets ?? this.sets,
    isEditing: isEditing ?? this.isEditing,
      createEditToggle: createEditToggle ?? this.createEditToggle
  );
}
