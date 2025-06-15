import '../../features/matches/domain/entities/day_availability.dart';

class DatePickerHelper {
  static List<int> getAvailableHours(
      DateTime date, List<DayAvailability> days) {
    final day = days.firstWhere(
      (d) => d.date.year == date.year &&
          d.date.month == date.month &&
          d.date.day == date.day,
      orElse: () => DayAvailability(date: date, hours: const []),
    );
    return day.hours;
  }
}


