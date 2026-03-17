class WorkoutLog {
  final String workoutName;
  final String date;
  final Duration sessionTime;
  final bool isTimerRunning;
  final double seriesProgress;
  final double timeProgress;
  final int pointsEarned;
  final String notes;
  final List<dynamic> addedExercises;
  final bool isFinished;

  WorkoutLog({
    this.workoutName = '',
    this.date = "",
    this.sessionTime = Duration.zero,
    this.isTimerRunning = false,
    this.seriesProgress = 0.0,
    this.timeProgress = 0.0,
    this.pointsEarned = 0,
    this.notes = '',
    this.addedExercises = const [],
    this.isFinished = false
  });

  WorkoutLog copyWith({
    String? workoutName,
    String? date,
    Duration? sessionTime,
    bool? isTimerRunning,
    String? notes,
    bool? isFinished,
  }){
    return WorkoutLog(
        workoutName: workoutName ?? this.workoutName,
        date: date ?? this.date,
        sessionTime: sessionTime ?? this.sessionTime,
        isTimerRunning: isTimerRunning ?? this.isTimerRunning,
        notes: notes ?? this.notes,
        isFinished: isFinished ?? this.isFinished
    );
  }
}