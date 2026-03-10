class WorkoutDay {
  final String dayName;
  final String description;
  final String? minutes;
  final bool isActive;

  WorkoutDay({
    required this.dayName,
    required this.description,
    this.minutes,
    this.isActive=false,
  });
}