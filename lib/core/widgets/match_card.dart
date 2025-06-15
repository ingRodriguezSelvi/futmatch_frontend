import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

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
            'Equipo A vs Equipo B',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text('30 may 2025 - 6.00 p.m.'),
          const SizedBox(height: 4),
          const Text(
            'Ubicacion: Canchas San Vicente',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('7 vs 7'),
              Row(
                children: const [
                  Icon(Icons.person, size: 16),
                  SizedBox(width: 4),
                  Text('14 jugadores'),
                ],
              ),
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
        ],
      ),
    );
  }
}
