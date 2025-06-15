part of 'auth_bloc.dart';

sealed class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  LoginRequested(this.email, this.password, this.rememberMe);
}
