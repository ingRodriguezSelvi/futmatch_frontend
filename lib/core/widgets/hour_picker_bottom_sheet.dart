import 'package:flutter/material.dart';

class HourPickerBottomSheet extends StatelessWidget {
  final List<int> availableHours;
  final void Function(int) onHourSelected;

  const HourPickerBottomSheet({
    super.key,
    required this.availableHours,
    required this.onHourSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: availableHours.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            final hour = availableHours[index];
            return GestureDetector(
              onTap: () {
                onHourSelected(hour);
                Navigator.of(context).pop();
              },
              child: Card(
                child: Center(child: Text('$hour:00')),
              ),
            );
          },
        ),
      ),
    );
  }
}


