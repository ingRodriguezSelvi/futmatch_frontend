import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futmatch_frontend/core/di.dart';
import 'package:futmatch_frontend/core/styles/app_colors.dart';
import 'package:futmatch_frontend/core/styles/input_decoration.dart';
import 'package:futmatch_frontend/core/widgets/circle_logo.dart';
import 'package:futmatch_frontend/core/widgets/gradient_button.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final ValueNotifier<bool> _rememberMe = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: Builder(
          builder: (context) => BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }

              if (state is Authenticated) {
                // Navega al home
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 18,
                            color: Colors.black.withOpacity(.06),
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleLogo(assetPath: 'assets/images/logo.png'),
                          const SizedBox(height: 24),
                          Text(
                            'Bienvenido a\nFutMatch!',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Organiza y juega partidos\nfácilmente',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: customInputDecoration('Correo electrónico'),
                            //Disable auto-correct
                            autocorrect: false,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _pwdCtrl,
                            obscureText: true,
                            decoration: customInputDecoration('Contraseña').copyWith(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility_rounded),
                                onPressed: () {}, // Agrega lógica de visibilidad
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ValueListenableBuilder<bool>(
                            valueListenable: _rememberMe,
                            builder: (_, value, __) => InkWell(
                              onTap: () => _rememberMe.value = !value,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: value,
                                    onChanged: (v) => _rememberMe.value = v ?? false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Expanded(child: Text('Recordarme')),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('¿Olvidaste?'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;
                              return GradientButton(
                                text: isLoading ? 'Ingresando...' : 'Ingresar',
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  context.read<AuthBloc>().add(
                                  LoginRequested(
                                      _emailCtrl.text,
                                      _pwdCtrl.text,
                                      _rememberMe.value,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
