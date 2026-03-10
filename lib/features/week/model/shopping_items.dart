class ShoppingItems {
  final String name;
  final String quantity;
  final String? subtitle;
  final bool isChecked;
  ShoppingItems({
    required this.name,
    required this.quantity,
    this.subtitle,
    this.isChecked = false
  });

  ShoppingItems copyWith({bool? isChecked}){
    return ShoppingItems(
      name: name,
      quantity: quantity,
      subtitle: subtitle,
      isChecked: isChecked ?? this.isChecked
    );
  }

}