import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/input_decoration.dart';
import '../blocs/matches_bloc/matches_bloc.dart';

class CreateMatchScreen extends StatelessWidget {
  CreateMatchScreen({super.key});

  final _homeCtrl = TextEditingController();
  final _awayCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Partido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<MatchesBloc, MatchesState>(
          listener: (context, state) {
            if (state is MatchesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is MatchLoaded) {
              Navigator.of(context).pop(state.match);
            }
          },
          builder: (context, state) {
            final loading = state is MatchesLoading;
            return Column(
              children: [
                TextField(
                  controller: _homeCtrl,
                  decoration: customInputDecoration('Equipo local'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _awayCtrl,
                  decoration: customInputDecoration('Equipo visitante'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _locationCtrl,
                  decoration: customInputDecoration('Ubicación'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _dateCtrl,
                  decoration: customInputDecoration('Fecha (YYYY-MM-DD HH:MM)'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () {
                          context.read<MatchesBloc>().add(
                                CreateMatchRequested({
                                  'homeTeam': _homeCtrl.text,
                                  'awayTeam': _awayCtrl.text,
                                  'location': _locationCtrl.text,
                                  'date': _dateCtrl.text,
                                }),
                              );
                        },
                  child: Text(loading ? 'Creando...' : 'Crear'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
