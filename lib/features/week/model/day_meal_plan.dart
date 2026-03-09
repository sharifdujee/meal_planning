import 'package:meal_planning/features/week/model/meal.dart';

class DayMealPlan {
  final String dayName;
  final List<Meal> meals;
  final bool isConfirmed;

  DayMealPlan({
    required this.dayName,
    required this.meals,
    this.isConfirmed = false,
  });
}
