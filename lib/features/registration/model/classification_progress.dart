class ClassificationProgress {
  final int currentSeries;
  final int totalSeries;
  final int currentMinutes;
  final int totalMinutes;
  final int currentPoints;
  final int goalPoints;
  final List<String> pointHints;

  ClassificationProgress({
    required this.currentSeries,
    required this.totalSeries,
    required this.currentMinutes,
    required this.totalMinutes,
    required this.currentPoints,
    required this.goalPoints,
    this.pointHints = const [],
  });

  // Getters for progress calculation
  double get seriesProgress => (currentSeries / totalSeries).clamp(0.0, 1.0);
  double get timeProgress => (currentMinutes / totalMinutes).clamp(0.0, 1.0);
  double get pointProgress => (currentPoints / goalPoints).clamp(0.0, 1.0);

  // Getter for the display string
  String get totalPointsDisplay => currentPoints.toString();

  // Helper to create a new instance with updated values
  ClassificationProgress copyWith({
    int? currentSeries,
    int? currentMinutes,
    int? currentPoints,
    List<String>? pointHints,
  }) {
    return ClassificationProgress(
      currentSeries: currentSeries ?? this.currentSeries,
      totalSeries: totalSeries, // Usually remains constant during a session
      currentMinutes: currentMinutes ?? this.currentMinutes,
      totalMinutes: totalMinutes,
      currentPoints: currentPoints ?? this.currentPoints,
      goalPoints: goalPoints,
      pointHints: pointHints ?? this.pointHints,
    );
  }
}