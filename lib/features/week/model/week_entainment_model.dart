enum DayStatus { completed, active, upcoming }

class WeekEntainmentModel {
  final DateTime date;
  final DayStatus status;

  const WeekEntainmentModel({required this.date, required this.status});

  WeekEntainmentModel copyWith({DateTime? date, DayStatus? status}) =>
      WeekEntainmentModel(date: date ?? this.date, status: status ?? this.status);
}