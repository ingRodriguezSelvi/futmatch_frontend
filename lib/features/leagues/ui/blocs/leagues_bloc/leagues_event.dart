part of 'leagues_bloc.dart';

abstract class LeaguesEvent {}

class CreateLeagueRequested extends LeaguesEvent {
  final String name;
  CreateLeagueRequested(this.name);
}

class JoinLeagueRequested extends LeaguesEvent {
  final String leagueId;
  JoinLeagueRequested(this.leagueId);
}

class LoadLeaguesRequested extends LeaguesEvent {}

class SelectLeagueRequested extends LeaguesEvent {
  final League league;
  SelectLeagueRequested(this.league);
}
