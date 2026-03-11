import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planning/features/week/model/shopping_items.dart';

final shoppingListProvider = NotifierProvider<ShoppingListNotifier, Map<String, List<ShoppingItems>>>(() {
  return ShoppingListNotifier();
});

class ShoppingListNotifier extends Notifier<Map<String, List<ShoppingItems>>> {
  @override
  Map<String, List<ShoppingItems>> build() {
    return {
      "Proteínas y carnes": [
        ShoppingItems(name: "Salmon", quantity: "150 g"),
        ShoppingItems(name: "Huevo", quantity: "2 unidades"),
        ShoppingItems(name: "Pavo", quantity: "150g"),
      ],
      "Verduras": [
        ShoppingItems(name: "Patata", quantity: "200 g"),
      ],
      "Suplementos": [
        ShoppingItems(name: "Proteína", quantity: "11 kg", subtitle: "Para 11 días")
      ],
    };
  }

  void toggleItem(String category, String itemName) {
    final currentState = state;
    if (!currentState.containsKey(category)) return;

    final updatedItems = currentState[category]!.map((item) {
      if (item.name == itemName) {
        return item.copyWith(isChecked: !(item.isChecked ?? false));
      }
      return item;
    }).toList();
    state = {
      ...currentState,
      category: updatedItems,
    };
  }
}