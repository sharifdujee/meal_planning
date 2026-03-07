class DayEntry {
  final String day;
  final String type;
  final String name;
  final String duration;
  final String notes;

  const DayEntry({
    required this.day,
    required this.type,
    this.name = '',
    this.duration = '',
    this.notes = '',
  });

  DayEntry copyWith({
    String? type,
    String? name,
    String? duration,
    String? notes,
  }) =>
      DayEntry(
        day: day,
        type: type ?? this.type,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        notes: notes ?? this.notes,
      );
}