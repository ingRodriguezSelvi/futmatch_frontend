import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/input_decoration.dart';
import '../../../../core/widgets/date_picker_prw.dart';
import '../blocs/matches_bloc/matches_bloc.dart';

class CreateMatchScreen extends StatefulWidget {
  CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  final _homeCtrl = TextEditingController();
  final _awayCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              child: BlocConsumer<MatchesBloc, MatchesState>(
                listener: (context, state) {
                  if (state is MatchesError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
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
                      DatePickerPrw(
                        labelText: 'Fecha',
                        hintText: 'Selecciona la fecha',
                        showTime: true,
                        onChanged: (d) => _selectedDate = d,
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed:
                            loading
                                ? null
                                : () {
                                  context.read<MatchesBloc>().add(
                                    CreateMatchRequested({
                                      'homeTeam': _homeCtrl.text,
                                      'awayTeam': _awayCtrl.text,
                                      'location': _locationCtrl.text,
                                      'date':
                                          _selectedDate?.toIso8601String() ??
                                          '',
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
          ),
        ],
      ),
    );
  }
}
