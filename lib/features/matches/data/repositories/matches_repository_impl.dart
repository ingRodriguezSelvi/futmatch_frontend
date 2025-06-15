import '../../domain/entities/match.dart';
import '../../domain/repositories/matches_repository.dart';
import '../datasources/matches_remote_datasource.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  final MatchesRemoteDataSource remoteDataSource;

  MatchesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Match> createMatch(Map<String, dynamic> request) =>
      remoteDataSource.createMatch(request);

  @override
  Future<Match> getMatch(String matchId) => remoteDataSource.getMatch(matchId);

  @override
  Future<Match> joinMatch(String matchId, Map<String, dynamic> request) =>
      remoteDataSource.joinMatch(matchId, request);

  @override
  Future<Match> cancelParticipation(String matchId, Map<String, dynamic> request) =>
      remoteDataSource.cancelParticipation(matchId, request);

  @override
  Future<Match> updateMatchResult(String matchId, Map<String, dynamic> request) =>
      remoteDataSource.updateMatchResult(matchId, request);
}
