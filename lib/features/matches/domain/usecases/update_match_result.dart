import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class UpdateMatchResult {
  final MatchesRepository repository;
  UpdateMatchResult(this.repository);

  Future<Match> call(String matchId, Map<String, dynamic> request) =>
      repository.updateMatchResult(matchId, request);
}
