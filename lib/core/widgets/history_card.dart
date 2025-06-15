import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Partido del 25 de mayo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text('Equipo A vs Equipo C'),
          const SizedBox(height: 4),
          const Text('Resultado: 3 - 2'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Ver detalles',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
