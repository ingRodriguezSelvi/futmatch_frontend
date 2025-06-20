import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futmatch_frontend/features/leagues/ui/screens/league_selection_screen.dart';

import '../../../leagues/domain/entities/league.dart';
import '../../../leagues/ui/blocs/leagues_bloc/leagues_bloc.dart';
import '../../../../core/widgets/history_card.dart';
import '../../../../core/widgets/match_card.dart';
import '../../../../core/widgets/new_card.dart';
import '../../../../core/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaguesBloc>().add(LoadLeaguesRequested());
  }

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
            title: BlocBuilder<LeaguesBloc, LeaguesState>(
              builder: (context, state) {
                final bloc = context.read<LeaguesBloc>();
                final leagues = bloc.leagues;
                final name = bloc.selectedLeague?.name ?? 'FutMatch';
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    if (leagues.isNotEmpty)
                      PopupMenuButton<League>(
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        onSelected: (l) => context
                            .read<LeaguesBloc>()
                            .add(SelectLeagueRequested(l)),
                        itemBuilder: (_) => [
                          for (final l in leagues)
                            PopupMenuItem(value: l, child: Text(l.name))
                        ],
                      ),
                  ],
                );
              },
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<LeaguesBloc>(),
                        child: const LeagueSelectionScreen(showBackButton: true),
                      ),
                    ),
                  );
                },
              ),
            ],
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
