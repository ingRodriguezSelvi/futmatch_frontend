import '../entities/match.dart';

abstract class MatchesRepository {
  Future<Match> createMatch(Map<String, dynamic> request);
  Future<Match> getMatch(String matchId);
  Future<Match> joinMatch(String matchId, Map<String, dynamic> request);
  Future<Match> cancelParticipation(String matchId, Map<String, dynamic> request);
  Future<Match> updateMatchResult(String matchId, Map<String, dynamic> request);
}
