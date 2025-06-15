import '../entities/match.dart';
import '../repositories/matches_repository.dart';

class CreateMatch {
  final MatchesRepository repository;
  CreateMatch(this.repository);

  Future<Match> call(Map<String, dynamic> request) =>
      repository.createMatch(request);
}
