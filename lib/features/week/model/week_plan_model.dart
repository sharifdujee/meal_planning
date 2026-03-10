enum WeekType {normal, complicated, minimal}

class WeekPlanModel {
  final WeekType type;
  final String title;
  final String description;
  final String Icon;

  WeekPlanModel({
    required this.type,
    required this.title,
    required this.description,
    required this.Icon,
  });
}