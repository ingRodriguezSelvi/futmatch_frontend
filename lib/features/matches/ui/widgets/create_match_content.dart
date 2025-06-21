import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di.dart';
import '../../../../core/styles/input_decoration.dart';
import '../../../../core/widgets/fut_button.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../fields/domain/entities/field.dart';
import '../../../fields/domain/usecases/get_fields.dart';
import '../blocs/matches_bloc/matches_bloc.dart';
import '../../../leagues/ui/blocs/leagues_bloc/leagues_bloc.dart';
import '../widgets/date_time_picker_bottom_sheet.dart';
import 'dart:convert';

class CreateMatchContent extends StatefulWidget {
  const CreateMatchContent({super.key});

  @override
  State<CreateMatchContent> createState() => _CreateMatchContentState();
}

class _CreateMatchContentState extends State<CreateMatchContent> {
  final _dateCtrl = TextEditingController();

  final List<Field> _fields = [];
  Field? _selectedField;
  int _teamSize = 5;
  String? _userId;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final local = sl<AuthLocalDataSource>();
    final tokens = await local.getTokens();
    if (tokens == null) return;
    final parts = tokens.accessToken.split('.');
    if (parts.length == 3) {
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      _userId = decoded['sub'] as String?;
    }

    try {
      final fields = await sl<GetFields>()();
      setState(() {
        _fields
          ..clear()
          ..addAll(fields);
        if (_fields.isNotEmpty) _selectedField = _fields.first;
      });
    } catch (_) {
      // Ignorar error de carga inicial
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: const Text('Liga FutMatch',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
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
                      DropdownButtonFormField<Field>(
                        value: _selectedField,
                        items: [
                          for (final f in _fields)
                            DropdownMenuItem(value: f, child: Text(f.name))
                        ],
                        decoration: customInputDecoration('Cancha'),
                        onChanged: (f) => setState(() => _selectedField = f),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        value: _teamSize,
                        items: const [
                          DropdownMenuItem(value: 5, child: Text('5')),
                          DropdownMenuItem(value: 7, child: Text('7')),
                          DropdownMenuItem(value: 11, child: Text('11')),
                        ],
                        decoration: customInputDecoration('Tamaño del equipo'),
                        onChanged: (v) => setState(() => _teamSize = v ?? 5),
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
                      const SizedBox(height: 24),
                      FutButton(
                        onPressed: loading
                            ? null
                            : () {
                          final leagueId = context
                              .read<LeaguesBloc>()
                              .selectedLeague
                              ?.id;

                          if (leagueId == null ||
                              _selectedField == null ||
                              _userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text('Completa todos los campos'),
                              ),
                            );
                            return;
                          }

                          context.read<MatchesBloc>().add(
                            CreateMatchRequested({
                              'leagueId': leagueId,
                              'fieldId': _selectedField!.id,
                              'teamSize': _teamSize,
                              'createdBy': _userId!,
                              'scheduledAt': _selectedDate
                                  ?.toIso8601String() ??
                                  '',
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
