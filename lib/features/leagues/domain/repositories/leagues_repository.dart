import '../entities/league.dart';

abstract class LeaguesRepository {
  Future<List<League>> getLeaguesForUser(String userId, String token);
}
