part of 'leagues_bloc.dart';

abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoading extends LeaguesState {}

class LeagueLoaded extends LeaguesState {
  final League league;
  LeagueLoaded(this.league);
}

class LeaguesListLoaded extends LeaguesState {
  final List<League> leagues;
  final League? selected;
  LeaguesListLoaded(this.leagues, this.selected);
}

class LeaguesError extends LeaguesState {
  final String message;
  LeaguesError(this.message);
}
