import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/week/model/day_meal_plan.dart';
import '../model/meal.dart';

import '../../../core/utils/icon_path.dart';

// Provides the list of meal plans for the week.
final weekMealProvider = Provider<List<DayMealPlan>>((ref) {
  return [
    DayMealPlan(
      dayName: 'Domingo',
      isConfirmed: true,
      meals: [
        Meal(
          category: "DESAYUNO",
          title: "Batido de bayas",
          imageIcon: IconPath.tea,
          chefName: "Ver Receta",
        ),
        Meal(
          category: "ALMUERZO",
          title: "Camarones y quinoa",
          description:
              "Un tazón personalizable y rico en nutrientes con proteína magra y cereales integrales.",
          imageIcon: IconPath.restaurant02,
          chefName: "Ver Receta",
        ),
        Meal(
          category: "BOCADILLO",
          title: "Un puñado pequeño de almendras",
          description: "Un refrigerio saludable y saciante.",
          imageIcon: IconPath.cookie,
          chefName: "Ver Receta",
        ),
        Meal(
          title: "Brochetas De Pollo Y Verduras",
          description:
              "Brochetas ligeras y coloridas, perfectas para una cena ligera y personalizable.",
          imageIcon: IconPath.moon02,
          chefName: "Ver Receta",
        ),
      ],
    ),
    DayMealPlan(dayName: "Lunes", meals: []),
    DayMealPlan(dayName: "Martes", meals: []),
    DayMealPlan(dayName: "Miércoles", meals: []),
    DayMealPlan(dayName: "Jueves", meals: []),
    DayMealPlan(dayName: "Viernes", meals: []),
    DayMealPlan(dayName: "Sábado", meals: []),
  ];
});

// Tracks which day's card is expanded in the UI.
final expandedDayProvider = StateProvider<String?>((ref) => 'Domingo');

// These providers are intended to be overridden by a specific value
// when a card/meal needs to supply its data downstream.
final currentDayPlanProvider = Provider<DayMealPlan>((ref) {
  throw UnimplementedError(
    'currentDayPlanProvider must be overridden with a DayMealPlan',
  );
});

final currentMealProvider = Provider<Meal>((ref) {
  throw UnimplementedError(
    'currentMealProvider must be overridden with a Meal',
  );
});
