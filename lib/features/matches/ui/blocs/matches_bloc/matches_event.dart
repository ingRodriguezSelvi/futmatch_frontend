part of 'matches_bloc.dart';

abstract class MatchesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateMatchRequested extends MatchesEvent {
  final Map<String, dynamic> request;
  CreateMatchRequested(this.request);
}

class GetMatchRequested extends MatchesEvent {
  final String matchId;
  GetMatchRequested(this.matchId);
}

class JoinMatchRequested extends MatchesEvent {
  final String matchId;
  final Map<String, dynamic> request;
  JoinMatchRequested(this.matchId, this.request);
}

class CancelParticipationRequested extends MatchesEvent {
  final String matchId;
  final Map<String, dynamic> request;
  CancelParticipationRequested(this.matchId, this.request);
}

class LoadMatchesRequested extends MatchesEvent {}

class UpdateResultRequested extends MatchesEvent {
  final String matchId;
  final Map<String, dynamic> request;
  UpdateResultRequested(this.matchId, this.request);
}
