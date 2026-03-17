class FoodItem {
  final String name;
  final int proteinPerUnit;
  int quantity;

  FoodItem({
    required this.name,
    required this.proteinPerUnit,
    this.quantity = 1,
  });

  int get totalProtein => proteinPerUnit * quantity;
}