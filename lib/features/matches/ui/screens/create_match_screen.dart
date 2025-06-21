import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:futmatch_frontend/core/widgets/fut_button.dart';

import '../../../../core/styles/input_decoration.dart';
import '../blocs/matches_bloc/matches_bloc.dart';
import '../widgets/date_time_picker_bottom_sheet.dart';

class CreateMatchScreen extends StatefulWidget {
  CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  final _fieldCtrl = TextEditingController();
  final _teamSizeCtrl = TextEditingController();
  final _createdByCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
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
                        controller: _fieldCtrl,
                        decoration: customInputDecoration('Campo'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _teamSizeCtrl,
                        decoration: customInputDecoration('Tamaño del equipo'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _createdByCtrl,
                        decoration: customInputDecoration('Creado por'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _dateCtrl,
                        readOnly: true,
                        decoration: customInputDecoration('Fecha y hora'),
                        onTap: () async {
                          final date = await showDateTimePickerBottomSheet(
                            context,
                            initialDate: _selectedDate,
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                              _dateCtrl.text =
                                  DateFormat('yyyy-MM-dd HH:mm').format(date);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 24),
                      FutButton(
                        onPressed: loading
                            ? null
                            : () {
                                context.read<MatchesBloc>().add(
                                  CreateMatchRequested({
                                    'fieldId': _fieldCtrl.text,
                                    'teamSize': _teamSizeCtrl.text,
                                    'createdBy': _createdByCtrl.text,
                                    'scheduledAt':
                                        _selectedDate?.toIso8601String() ?? '',
                                  }),
                                );
                              },
                        text: loading ? 'Creando...' : 'Crear partido',
                      )
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
