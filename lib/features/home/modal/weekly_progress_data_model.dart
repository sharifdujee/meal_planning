enum DayStatus { completed, active, upcoming }

class WeekDayModel {
  final DateTime date;
  final DayStatus status;

  const WeekDayModel({required this.date, required this.status});

  WeekDayModel copyWith({DateTime? date, DayStatus? status}) =>
      WeekDayModel(date: date ?? this.date, status: status ?? this.status);
}