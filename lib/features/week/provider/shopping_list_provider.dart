import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/features/week/model/shopping_items.dart';

final shoppingListProvider = StateProvider<Map<String,List<ShoppingItems>>>((ref){
  return {
    "Proteínas y carnes" : [
      ShoppingItems(name: "Salmon", quantity: "150 g"),
      ShoppingItems(name: "Huevo", quantity: "2 unidades"),
      ShoppingItems(name: "Pavo", quantity: "150g"),
    ],
    "Verduras" : [
      ShoppingItems(name: "Patata", quantity: "200 g"),
    ],
    "Suplementos" : [
      ShoppingItems(name: "Proteína", quantity: "11 kg", subtitle: "Para 11 días")
    ],
  };
});