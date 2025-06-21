import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../../../leagues/ui/blocs/leagues_bloc/leagues_bloc.dart';
import '../blocs/matches_bloc/matches_bloc.dart';
import '../widgets/create_match_content.dart';


class CreateMatchScreen extends StatelessWidget {
  const CreateMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaguesBloc>(
          create: (_) => sl<LeaguesBloc>()..add(LoadLeaguesRequested()), // Opcional
        ),
        BlocProvider<MatchesBloc>(
          create: (_) => sl<MatchesBloc>(),
        ),
      ],
      child: const CreateMatchContent(),
    );
  }
}
