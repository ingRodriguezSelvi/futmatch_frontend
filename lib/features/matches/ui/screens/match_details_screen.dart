import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/matches_bloc/matches_bloc.dart';

class MatchDetailsScreen extends StatelessWidget {
  final String matchId;
  const MatchDetailsScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Partido')),
      body: BlocBuilder<MatchesBloc, MatchesState>(
        builder: (context, state) {
          if (state is MatchesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MatchesError) {
            return Center(child: Text(state.message));
          }
          if (state is MatchLoaded) {
            final match = state.match;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${match.homeTeam} vs ${match.awayTeam}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(match.location),
                  const SizedBox(height: 8),
                  Text(match.date.toString()),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MatchesBloc>().add(GetMatchRequested(matchId));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
