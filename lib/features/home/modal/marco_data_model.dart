

class MacroData {
  final String mealName;
  final int calories;
  final int protein;     // grams
  final int carbs;       // grams
  final int fat;         // grams
  final double proteinPercent;
  final double carbsPercent;
  final double fatPercent;

  const MacroData({
    required this.mealName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.proteinPercent,
    required this.carbsPercent,
    required this.fatPercent,
  });
}