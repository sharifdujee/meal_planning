
import 'package:flutter_riverpod/legacy.dart';

class FoodSelectionNotifier extends StateNotifier<List<String>> {
  FoodSelectionNotifier() : super(["Verduras"]); // Default selected

  void toggle(String food) {
    if (state.contains(food)) {
      state = state.where((item) => item != food).toList();
    } else {
      state = [...state, food];
    }
  }

  bool isSelected(String food) => state.contains(food);
}

final foodSelectionProvider =
StateNotifierProvider<FoodSelectionNotifier, List<String>>(
        (ref) => FoodSelectionNotifier());