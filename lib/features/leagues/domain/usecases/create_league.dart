import '../entities/league.dart';
import '../repositories/leagues_repository.dart';

class CreateLeague {
  final LeaguesRepository repository;
  CreateLeague(this.repository);

  Future<League> call(Map<String, dynamic> request, String token) =>
      repository.createLeague(request, token);
}
