import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FoodItem {
  final String name;
  final int proteinPerUnit;
  final int quantity;

  FoodItem({required this.name, required this.proteinPerUnit, this.quantity = 1});

  int get totalProtein => proteinPerUnit * quantity;

  // Needed to update state in Riverpod
  FoodItem copyWith({int? quantity}) {
    return FoodItem(
      name: name,
      proteinPerUnit: proteinPerUnit,
      quantity: quantity ?? this.quantity,
    );
  }
}

// The Provider definition
final proteinProvider = StateNotifierProvider<ProteinNotifier, List<FoodItem>>((ref) {
  return ProteinNotifier();
});

class ProteinNotifier extends StateNotifier<List<FoodItem>> {
  ProteinNotifier() : super([
    FoodItem(name: "Salmon", proteinPerUnit: 25, quantity: 2),
    FoodItem(name: "Salmon", proteinPerUnit: 25, quantity: 2),
    FoodItem(name: "Eggs", proteinPerUnit: 12, quantity: 2),
    FoodItem(name: "Tuna", proteinPerUnit: 29, quantity: 2),
  ]);

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) state[i].copyWith(quantity: newQuantity) else state[i],
      ];
    }
  }

  int get grandTotal => state.fold(0, (sum, item) => sum + item.totalProtein);
}