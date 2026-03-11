class WorkoutDay {
  final String dayName;
  final String description;
  final String? minutes;
  final bool isActive;
  final List<Instruction> instructions;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.dayName,
    required this.description,
    this.minutes,
    this.isActive = false,
    this.instructions = const [],
    this.exercises = const [],
  });
}

class Instruction {
  final String text;
  Instruction({required this.text});
}

class Exercise {
  final String name;
  final String setsAndReps; // e.g., "1x2 minutos"
  final String? explanationUrl;

  final String? targetMuscles;
  final List<String> positioningSteps;
  final List<String> executionSteps;
  final String? successSignal;
  final String? commonError;

  Exercise({
    required this.name,
    required this.setsAndReps,
    this.explanationUrl,

    this.targetMuscles,
    this.positioningSteps = const[],
    this.executionSteps = const[],
    this.successSignal,
    this.commonError
  });
}