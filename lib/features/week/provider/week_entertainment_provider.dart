
import 'package:flutter_riverpod/legacy.dart';
import '../model/week_entainment_model.dart';

List<WeekEntainmentModel> _buildWeekDays() {
  final today = DateTime.now();
  final monday = today.subtract(Duration(days: today.weekday - 1));

  return List.generate(7, (index) {
    final date = monday.add(Duration(days: index));
    final d = DateTime(date.year, date.month, date.day);
    final t = DateTime(today.year, today.month, today.day);

    final status = d.isBefore(t)
        ? DayStatus.completed
        : d.isAtSameMomentAs(t)
        ? DayStatus.active
        : DayStatus.upcoming;

    return WeekEntainmentModel(date: date, status: status);
  });
}

class WeeklyEntertainmentNotifier extends StateNotifier<List<WeekEntainmentModel>> {
  WeeklyEntertainmentNotifier() : super(_buildWeekDays());

  void toggleDay(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    state = state.map((day) {
      final dayOnly = DateTime(day.date.year, day.date.month, day.date.day);
      final target  = DateTime(date.year, date.month, date.day);
      if (!dayOnly.isAtSameMomentAs(target)) return day;

      if (dayOnly.isAtSameMomentAs(todayOnly)) {
        return day.copyWith(
          status: day.status == DayStatus.completed
              ? DayStatus.active
              : DayStatus.completed,
        );
      }

      return day.copyWith(
        status: day.status == DayStatus.completed
            ? DayStatus.upcoming
            : DayStatus.completed,
      );
    }).toList();
  }
}

final weeklyEntertainmentProvider =
StateNotifierProvider<WeeklyEntertainmentNotifier, List<WeekEntainmentModel>>(
      (ref) => WeeklyEntertainmentNotifier(),
);