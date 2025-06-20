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

    final primaryColor = Colors.blue;
    final accentColor = const Color(0xFF26EC77);
    final backgroundColor = const Color(0xFFF4F6FA);

    return BlocProvider(
      create: (_) => sl<LeaguesBloc>(),
      child: BlocConsumer<LeaguesBloc, LeaguesState>(
        listener: (context, state) {
          if (state is LeagueLoaded) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is LeaguesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final loading = state is LeaguesLoading;

          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.sports_soccer, size: 48, color: Colors.blue),
                        const SizedBox(height: 16),
                        const Text(
                          'Selecciona una liga',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Únete o crea una liga para comenzar a jugar',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 32),

                        // Crear nueva liga
                        const Text(
                          'Crear una liga nueva',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
                            hintText: 'Nombre de la liga',
                            filled: true,
                            fillColor: const Color(0xFFF4F6FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: loading
                              ? null
                              : () {
                            context.read<LeaguesBloc>().add(
                              CreateLeagueRequested(nameCtrl.text),
                            );
                          },
                          child: Text(loading ? 'Creando...' : 'Crear liga',style: TextStyle(color: Colors.white),),
                        ),

                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 24),

                        // Unirse a liga
                        const Text(
                          'Unirse a una liga',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: codeCtrl,
                          decoration: InputDecoration(
                            hintText: 'Código de invitación',
                            filled: true,
                            fillColor: const Color(0xFFF4F6FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: primaryColor, width: 1),
                            ),
                          ),
                          onPressed: loading
                              ? null
                              : () {
                            context.read<LeaguesBloc>().add(
                              JoinLeagueRequested(codeCtrl.text),
                            );
                          },
                          child: Text(loading ? 'Uniendo...' : 'Unirse a liga',style: TextStyle(color: primaryColor),),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
