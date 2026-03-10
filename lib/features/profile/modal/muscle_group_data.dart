

// lib/models/muscle_group.dart

import 'package:flutter/material.dart';

class MuscleGroup {
  final String id;
  final String name;
  final String icon;
  final Color accentColor;
  final List<String> exercises;

  const MuscleGroup({
    required this.id,
    required this.name,
    required this.icon,
    required this.accentColor,
    required this.exercises,
  });
}

final List<MuscleGroup> muscleGroups = [
  MuscleGroup(
    id: 'pecho',
    name: 'Pecho',
    icon: '🫁',
    accentColor: const Color(0xFF00FF87),
    exercises: [
      'Press de banca con mancuernas',
      'Aperturas con mancuernas',
      'Flexiones diamante',
      'Press inclinado',
      'Crossover en polea',
    ],
  ),
  MuscleGroup(
    id: 'espalda',
    name: 'Espalda',
    icon: '🦴',
    accentColor: const Color(0xFF00CFFF),
    exercises: [
      'Dominadas',
      'Remo con barra',
      'Jalón al pecho',
      'Remo con mancuerna',
      'Pull-over con mancuerna',
    ],
  ),
  MuscleGroup(
    id: 'hombros',
    name: 'Hombros',
    icon: '🏋️',
    accentColor: const Color(0xFFFF6B6B),
    exercises: [
      'Press militar',
      'Elevaciones laterales',
      'Pájaros',
      'Press Arnold',
      'Face pull',
    ],
  ),
  MuscleGroup(
    id: 'piernas',
    name: 'Piernas',
    icon: '🦵',
    accentColor: const Color(0xFFFFB347),
    exercises: [
      'Sentadillas',
      'Peso muerto',
      'Zancadas',
      'Prensa de piernas',
      'Curl femoral',
    ],
  ),
  MuscleGroup(
    id: 'brazos',
    name: 'Brazos',
    icon: '💪',
    accentColor: const Color(0xFFC77DFF),
    exercises: [
      'Curl de bíceps',
      'Tríceps en polea',
      'Martillo',
      'Fondos en paralelas',
      'Curl concentrado',
    ],
  ),
  MuscleGroup(
    id: 'core',
    name: 'Core',
    icon: '⚡',
    accentColor: const Color(0xFFFF9F1C),
    exercises: [
      'Plancha',
      'Crunch abdominal',
      'Rueda abdominal',
      'Elevación de piernas',
      'Russian twist',
    ],
  ),
];