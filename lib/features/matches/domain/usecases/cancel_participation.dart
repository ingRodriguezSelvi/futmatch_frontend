import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class CancelParticipation {
  final MatchesRepository repository;
  CancelParticipation(this.repository);

  Future<Match> call(String matchId, Map<String, dynamic> request) =>
      repository.cancelParticipation(matchId, request);
}
