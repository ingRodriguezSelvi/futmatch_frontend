import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/matches/domain/entities/day_availability.dart';
import '../functions/date_picker_helper.dart';
import 'calendar_bottom_sheet.dart';
import 'hour_picker_bottom_sheet.dart';

class DatePickerPrw extends StatefulWidget {
  const DatePickerPrw({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.showTime = false,
    this.availableDays,
    this.allowPastDates = false,
  });

  final String labelText;
  final String hintText;
  final bool showTime;
  final String? Function(DateTime?)? validator;
  final void Function(DateTime) onChanged;
  final List<DayAvailability>? availableDays;
  final bool allowPastDates;

  @override
  State<DatePickerPrw> createState() => _DatePickerPrwState();
}

class _DatePickerPrwState extends State<DatePickerPrw> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final dateFormat = widget.showTime
        ? DateFormat('dd/MM/yyyy HH:mm')
        : DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _openDatePicker(context),
          child: Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Color(0xff666666)),
                const SizedBox(width: 10),
                Text(
                  _selectedDate == null
                      ? widget.hintText
                      : dateFormat.format(_selectedDate!),
                  style: TextStyle(
                    color: _selectedDate == null ? Colors.grey : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.validator?.call(_selectedDate) ?? '',
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ],
    );
  }

  Future<void> _openDatePicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CalendarBottomSheet(
        availableDays: widget.availableDays,
        allowPastDates: widget.allowPastDates,
        onDateSelected: (selectedDate) async {
          if (!widget.allowPastDates) {
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            if (selectedDate.isBefore(today)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('No se puede seleccionar una fecha pasada')),
              );
              return;
            }
          }

          if (widget.showTime && widget.availableDays != null) {
            final hours = DatePickerHelper.getAvailableHours(
              selectedDate,
              widget.availableDays!,
            );

            if (hours.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('No hay horas disponibles para esta fecha')),
              );
              return;
            }

            await showModalBottomSheet(
              context: context,
              builder: (_) => HourPickerBottomSheet(
                availableHours: hours,
                onHourSelected: (hour) {
                  final finalDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    hour,
                  );
                  _setDate(finalDate);
                },
              ),
            );
          } else if (widget.showTime && widget.availableDays == null) {
            // allow selecting hour from 0-23
            await showModalBottomSheet(
              context: context,
              builder: (_) => HourPickerBottomSheet(
                availableHours: List.generate(24, (index) => index),
                onHourSelected: (hour) {
                  final finalDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    hour,
                  );
                  _setDate(finalDate);
                },
              ),
            );
          } else {
            _setDate(selectedDate);
          }
        },
      ),
    );
  }

  void _setDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onChanged(date);
  }
}


