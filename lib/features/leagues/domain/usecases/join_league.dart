import '../entities/league.dart';
import '../repositories/leagues_repository.dart';

class JoinLeague {
  final LeaguesRepository repository;
  JoinLeague(this.repository);

  Future<League> call(String leagueId, Map<String, dynamic> request, String token) =>
      repository.joinLeague(leagueId, request, token);
}
