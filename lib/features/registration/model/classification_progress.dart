class ClassificationProgress {
  final int currentSeries;
  final int totalSeries;
  final int currentMinutes;
  final int totalMinutes;
  final int currentPoints;
  final int goalPoints;
  final int totalPointsDisplay;
  final List<String> pointHints;

  ClassificationProgress({
    required this.currentSeries,
    required this.totalSeries,
    required this.currentMinutes,
    required this.totalMinutes,
    required this.currentPoints,
    required this.goalPoints,
    required this.totalPointsDisplay,
    this.pointHints = const []
  });

  double get seriesProgress => (currentSeries/totalSeries).clamp(0.0, 1.0);
  double get timeProgress => (currentMinutes/totalMinutes).clamp(0.0, 1.0);
  double get pointProgress => (currentPoints/goalPoints).clamp(0.0, 1.0);
}