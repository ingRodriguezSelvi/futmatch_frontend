import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../features/matches/domain/entities/day_availability.dart';

class CalendarBottomSheet extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  final List<DayAvailability>? availableDays;
  final bool allowPastDates;

  const CalendarBottomSheet({
    super.key,
    required this.onDateSelected,
    this.availableDays,
    this.allowPastDates = false,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isDayEnabled(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (!widget.allowPastDates && day.isBefore(today)) {
      return false;
    }
    if (widget.availableDays == null) return true;
    return widget.availableDays!.any((d) =>
        d.date.year == day.year &&
        d.date.month == day.month &&
        d.date.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => _selectedDay != null &&
                  day.year == _selectedDay!.year &&
                  day.month == _selectedDay!.month &&
                  day.day == _selectedDay!.day,
              onDaySelected: (selected, focused) {
                if (_isDayEnabled(selected)) {
                  setState(() {
                    _focusedDay = focused;
                    _selectedDay = selected;
                  });
                }
              },
              enabledDayPredicate: _isDayEnabled,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedDay == null
                  ? null
                  : () {
                      widget.onDateSelected(_selectedDay!);
                      Navigator.of(context).pop();
                    },
              child: const Text('Seleccionar'),
            ),
          ],
        ),
      ),
    );
  }
}


