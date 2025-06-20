import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/input_decoration.dart';
import '../../../../core/widgets/fut_button.dart';
import '../blocs/leagues_bloc/leagues_bloc.dart';

class LeagueSelectionScreen extends StatelessWidget {
  final bool showBackButton;

  const LeagueSelectionScreen({super.key, this.showBackButton = false});

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
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final loading = state is LeaguesLoading;

          return Scaffold(
            backgroundColor: AppColors.background,
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
                        if (showBackButton)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
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
                          decoration:
                              customInputDecoration('Nombre de la liga'),
                        ),
                        const SizedBox(height: 16),
                        FutButton(
                          text: 'Crear liga',
                          loadingText: 'Creando...',
                          loading: loading,
                          onPressed: () {
                            context.read<LeaguesBloc>().add(
                              CreateLeagueRequested(nameCtrl.text),
                            );
                          },
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
                          decoration:
                              customInputDecoration('Código de invitación'),
                        ),
                        const SizedBox(height: 16),
                        FutButton(
                          text: 'Unirse a liga',
                          loadingText: 'Uniendo...',
                          loading: loading,
                          color: Colors.white,
                          borderColor: AppColors.primary,
                          textColor: AppColors.primary,
                          onPressed: () {
                            context.read<LeaguesBloc>().add(
                              JoinLeagueRequested(codeCtrl.text),
                            );
                          },
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
