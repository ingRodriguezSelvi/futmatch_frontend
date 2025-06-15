import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/match_card.dart';
import '../../../core/widgets/section_title.dart';
import 'package:futmatch_frontend/core/di.dart';
import 'blocs/matches_bloc/matches_bloc.dart';
import 'screens/create_match_screen.dart';
import 'screens/match_details_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MatchesBloc>(),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.blue,
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionTitle('Próximos partidos'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.blue, size: 28),
                              onPressed: () async {
                                final bloc = context.read<MatchesBloc>();
                                final match = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: bloc,
                                      child: CreateMatchScreen(),
                                    ),
                                  ),
                                );
                                if (match != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Partido creado'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<MatchesBloc>(),
                                  child: const MatchDetailsScreen(matchId: '1'),
                                ),
                              ),
                            );
                          },
                          child: const MatchCard(),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
