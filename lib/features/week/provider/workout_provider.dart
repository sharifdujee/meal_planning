import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/week/model/workout_day.dart';

final workoutProvider=StateProvider<List<WorkoutDay>>((ref)
{
  return [
    WorkoutDay(dayName: 'Domingo', description: "Cuerpo completo",minutes: '30'),
    WorkoutDay(dayName: "Lunes", description: "Cuerpo completo",minutes: '30'),
    WorkoutDay(dayName: "Martes", description: "Descansar"),
    WorkoutDay(dayName: "Miércoles", description: "Cuerpo completo",minutes: "30"),
    WorkoutDay(dayName: "Jueves", description: "Descansar",),
    WorkoutDay(dayName: "Viernes", description: "Cuerpo completo",isActive: true,minutes: "30"),
    WorkoutDay(dayName: "Sábado", description: "Descansar"),
  ];
});