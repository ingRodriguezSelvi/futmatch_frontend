import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../blocs/app_context_bloc/app_context_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppContextBloc>()..add(AppContextStarted()),
      child: BlocListener<AppContextBloc, AppContextState>(
        listener: (context, state) {
          if (state is AuthRequired) {
            Navigator.of(context).pushReplacementNamed('/login');
          } else if (state is LeagueSelectionRequired) {
            Navigator.of(context).pushReplacementNamed('/league-selection');
          } else if (state is AppContextReady) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
