import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class GetMatchDetails {
  final MatchesRepository repository;
  GetMatchDetails(this.repository);

  Future<Match> call(String matchId) => repository.getMatch(matchId);
}
