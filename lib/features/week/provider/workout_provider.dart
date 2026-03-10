import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/week/model/workout_day.dart';

final workoutProvider = StateProvider<List<WorkoutDay>>((ref) {
  return [
    WorkoutDay(
      dayName: "Martes",
      description: "Cuerpo Completo",
      minutes: "30",
      isActive: true,
      instructions: [
        Instruction(text: "Concéntrate en la técnica y la contracción."),
        Instruction(text: "Siente cómo trabaja el músculo en cada repetición."),
      ],
      exercises: [
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
        Exercise(name: "Marcha en el lugar", setsAndReps: "1x2 minutos"),
      ],
    ),
    WorkoutDay(
      dayName: "Lunes",
      description: "Cuerpo completo",
      minutes: '30',
      exercises: [
        Exercise(name: "Sentadillas", setsAndReps: "3x12"),
        Exercise(name: "Flexiones", setsAndReps: "3x10"),
      ],
    ),
    WorkoutDay(dayName: "Miércoles", description: "Descansar"),
    WorkoutDay(dayName: "Jueves", description: "Cuerpo completo", minutes: "30"),
    WorkoutDay(dayName: "Viernes", description: "Cuerpo completo", minutes: "30"),
    WorkoutDay(dayName: "Sábado", description: "Descansar"),
    WorkoutDay(dayName: 'Domingo', description: "Descansar"),
  ];
});