import 'package:flutter/material.dart';

import '../../features/matches/domain/entities/match.dart';

class MatchCard extends StatelessWidget {
  final Match? match;
  final VoidCallback? onDetails;

  const MatchCard({super.key, this.match, this.onDetails});

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
          Text(
            match != null
                ? '${match!.homeTeam} vs ${match!.awayTeam}'
                : 'Equipo A vs Equipo B',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(match != null ? match!.date.toString() : '30 may 2025 - 6.00 p.m.'),
          const SizedBox(height: 4),
          Text(
            match != null
                ? 'Ubicacion: ${match!.location}'
                : 'Ubicacion: Canchas San Vicente',
            style: const TextStyle(color: Colors.grey),
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
                onPressed: onDetails,
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
