import 'package:flutter/material.dart';
import '../../../../core/widgets/history_card.dart';
import '../../../../core/widgets/match_card.dart';
import '../../../../core/widgets/new_card.dart';
import '../../../../core/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  children: const [
                    SectionTitle('Próximos partidos'),
                    SizedBox(height: 12),
                    MatchCard(),
                    SizedBox(height: 32),
                    SectionTitle('Noticias'),
                    SizedBox(height: 12),
                    NewsCard(),
                    SizedBox(height: 32),
                    SectionTitle('Mi historial'),
                    SizedBox(height: 12),
                    HistoryCard(),
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
