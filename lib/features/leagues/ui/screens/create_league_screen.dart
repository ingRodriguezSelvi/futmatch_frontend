import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/input_decoration.dart';
import '../blocs/leagues_bloc/leagues_bloc.dart';

class CreateLeagueScreen extends StatefulWidget {
  const CreateLeagueScreen({super.key});

  @override
  State<CreateLeagueScreen> createState() => _CreateLeagueScreenState();
}

class _CreateLeagueScreenState extends State<CreateLeagueScreen> {
  final _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<LeaguesBloc>(),
      child: BlocConsumer<LeaguesBloc, LeaguesState>(
        listener: (context, state) {
          if (state is LeagueLoaded) {
            Navigator.of(context).pop();
          } else if (state is LeaguesError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final loading = state is LeaguesLoading;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text('Crear liga'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameCtrl,
                    decoration: customInputDecoration('Nombre de la liga'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            context
                                .read<LeaguesBloc>()
                                .add(CreateLeagueRequested(_nameCtrl.text));
                          },
                    child: Text(loading ? 'Creando...' : 'Crear'),
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
