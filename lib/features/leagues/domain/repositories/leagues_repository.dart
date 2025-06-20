import '../entities/league.dart';

abstract class LeaguesRepository {
  Future<List<League>> getLeaguesForUser(String userId, String token);
  Future<League> createLeague(
      Map<String, dynamic> request, String token);
  Future<League> joinLeague(
      String leagueId, Map<String, dynamic> request, String token);
}
