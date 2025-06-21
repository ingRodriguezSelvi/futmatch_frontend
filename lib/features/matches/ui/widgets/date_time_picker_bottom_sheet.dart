import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePickerBottomSheet(
    BuildContext context, {
      DateTime? initialDate,
    }) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      DateTime selectedDate = initialDate ?? DateTime.now();
      TimeOfDay selectedTime = TimeOfDay.now();
      bool dateSelected = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selecciona fecha y hora',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (!dateSelected)
                      CalendarDatePicker(
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                        onDateChanged: (date) {
                          setState(() {
                            selectedDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            dateSelected = true;
                          });
                        },
                      )
                    else ...[
                      const SizedBox(height: 16),
                      const Text('Selecciona la hora'),
                      SizedBox(
                        height: 300,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime(
                            0,
                            1,
                            1,
                            selectedTime.hour,
                            selectedTime.minute >= 30 ? 30 : 0,
                          ),
                          use24hFormat: true,
                          minuteInterval: 30, // <- Bloques de 30 minutos
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
