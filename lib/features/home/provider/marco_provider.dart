

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../modal/marco_data_model.dart';


final macroProvider = Provider<MacroData>((ref) {
  return const MacroData(
    mealName: 'Huevos revueltos',
    calories: 682,
    protein: 34,
    carbs: 51,
    fat: 14,
    proteinPercent: 0.23,
    carbsPercent: 0.52,
    fatPercent: 0.14,
  );
});