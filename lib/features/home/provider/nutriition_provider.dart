

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../modal/meal_data_model.dart';


// ── Meals list ─────────────────────────────────────────────
final mealsProvider = Provider<List<MealModel>>((ref) => [
  const MealModel(
    type: MealType.desayuno,
    title: 'Batido de Bayas',
    description:
    'Un batido rápido y nutritivo lleno de antioxidantes.',
  ),
  const MealModel(
    type: MealType.almuerzo,
    title: 'Camarones con quinoa',
    description:
    'A customizable and nutrient-dense bowl with\nlean protein and whole grains.',
  ),
  const MealModel(
    type: MealType.merienda,
    title: 'Un pequeño puñado de almendras',
    description: 'Un snack saludable y satisfactorio.',
  ),
  const MealModel(
    type: MealType.cena,
    title: 'Brochetas de Pollo y Verduras',
    description:
    'Brochetas coloridas y magras, perfectas para una cena ligera y personalizable.',
  ),
]);

// ── Supplements toggle ─────────────────────────────────────
final supplementsProvider =
StateProvider<bool>((ref) => true);