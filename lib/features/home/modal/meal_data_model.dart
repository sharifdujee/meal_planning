

enum MealType { desayuno, almuerzo, merienda, cena }

class MealModel {
  final MealType type;
  final String title;
  final String description;

  const MealModel({
    required this.type,
    required this.title,
    required this.description,
  });

  String get categoryLabel {
    switch (type) {
      case MealType.desayuno:  return 'DESAYUNO';
      case MealType.almuerzo:  return 'ALMUERZO';
      case MealType.merienda:  return 'MERIENDA';
      case MealType.cena:      return 'CENA';
    }
  }
}