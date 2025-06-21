import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePickerBottomSheet(
  BuildContext context, {
  DateTime? initialDate,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    builder: (ctx) {
      DateTime selectedDate = initialDate ?? DateTime.now();
      TimeOfDay selectedTime = TimeOfDay.fromDateTime(selectedDate);
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selecciona fecha y hora',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 5),
                    onDateChanged: (date) {
                      setState(() {
                        selectedDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: 180,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                        0,
                        0,
                        0,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                      use24hFormat: true,
                      onDateTimeChanged: (dt) {
                        setState(() {
                          selectedTime = TimeOfDay.fromDateTime(dt);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final result = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                      Navigator.of(context).pop(result);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
