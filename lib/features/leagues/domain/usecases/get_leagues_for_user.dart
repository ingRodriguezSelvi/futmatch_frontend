import '../entities/league.dart';
import '../repositories/leagues_repository.dart';

class GetLeaguesForUser {
  final LeaguesRepository repository;
  GetLeaguesForUser(this.repository);

  Future<List<League>> call(String userId, String token) =>
      repository.getLeaguesForUser(userId, token);
}
