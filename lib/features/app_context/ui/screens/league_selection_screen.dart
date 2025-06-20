import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../../../leagues/ui/blocs/leagues_bloc/leagues_bloc.dart';

class LeagueSelectionScreen extends StatelessWidget {
  const LeagueSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeCtrl = TextEditingController();
    final nameCtrl = TextEditingController();

    return BlocProvider(
      create: (_) => sl<LeaguesBloc>(),
      child: BlocConsumer<LeaguesBloc, LeaguesState>(
        listener: (context, state) {
          if (state is LeagueLoaded) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is LeaguesError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final loading = state is LeaguesLoading;
          return Scaffold(
            appBar: AppBar(title: const Text('Selecciona liga')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: codeCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Código de invitación',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            context
                                .read<LeaguesBloc>()
                                .add(JoinLeagueRequested(codeCtrl.text));
                          },
                    child:
                        Text(loading ? 'Uniendo...' : 'Unirse a liga'),
                  ),
                  const Divider(height: 32),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la liga',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            context
                                .read<LeaguesBloc>()
                                .add(CreateLeagueRequested(nameCtrl.text));
                          },
                    child: Text(loading ? 'Creando...' : 'Crear liga'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
