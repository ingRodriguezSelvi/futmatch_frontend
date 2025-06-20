part of 'app_context_bloc.dart';

sealed class AppContextState {}

class AppContextInitial extends AppContextState {}

class AppContextLoading extends AppContextState {}

class AuthRequired extends AppContextState {}

class LeagueSelectionRequired extends AppContextState {}

class AppContextReady extends AppContextState {}
