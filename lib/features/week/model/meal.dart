class Meal {
  final String category;
  final String title;
  final String description;
  final String imageIcon;
  final String chefName;
  Meal({
    this.category = "",
    required this.title,
    this.description ='',
    required this.imageIcon,
    required this.chefName,
  });
}