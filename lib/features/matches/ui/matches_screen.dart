import 'package:flutter/material.dart';
import '../../../../core/widgets/history_card.dart';
import '../../../../core/widgets/match_card.dart';
import '../../../../core/widgets/new_card.dart';
import '../../../../core/widgets/section_title.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blue, // fondo azul total
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: const Text(
              'Liga FutMatch',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          // Cuerpo redondeado blanco
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle('Próximos partidos'),
                        // Botón para agregar partido
                        IconButton(
                          icon: Icon(Icons.add_circle_outline, color: Colors.blue, size: 28),
                          onPressed: () {
                            // Acción para agregar partido
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    MatchCard(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
