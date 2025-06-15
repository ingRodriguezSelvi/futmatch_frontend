import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class JoinMatch {
  final MatchesRepository repository;
  JoinMatch(this.repository);

  Future<Match> call(String matchId, Map<String, dynamic> request) =>
      repository.joinMatch(matchId, request);
}
