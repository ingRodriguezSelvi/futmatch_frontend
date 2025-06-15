part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesError extends MatchesState {
  final String message;
  MatchesError(this.message);

  @override
  List<Object?> get props => [message];
}

class MatchLoaded extends MatchesState {
  final Match match;
  MatchLoaded(this.match);

  @override
  List<Object?> get props => [match];
}

class MatchesListLoaded extends MatchesState {
  final List<Match> matches;
  MatchesListLoaded(this.matches);

  @override
  List<Object?> get props => [matches];
}
