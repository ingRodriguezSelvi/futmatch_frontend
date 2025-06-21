import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../domain/entities/match.dart';
import '../../domain/repositories/matches_repository.dart';
import '../datasources/matches_remote_datasource.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  final MatchesRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  MatchesRepositoryImpl(this.remoteDataSource, this.localDataSource);

  Future<String> _getToken() async {
    final tokens = await localDataSource.getTokens();
    if (tokens == null) throw Exception('Usuario no autenticado');
    return tokens.accessToken;
  }

  @override
  Future<Match> createMatch(Map<String, dynamic> request) async {
    final token = await _getToken();
    return remoteDataSource.createMatch(request, token);
  }

  @override
  Future<Match> getMatch(String matchId) async {
    final token = await _getToken();
    return remoteDataSource.getMatch(matchId, token);
  }

  @override
  Future<Match> joinMatch(String matchId, Map<String, dynamic> request) async {
    final token = await _getToken();
    return remoteDataSource.joinMatch(matchId, request, token);
  }

  @override
  Future<Match> cancelParticipation(String matchId, Map<String, dynamic> request) async {
    final token = await _getToken();
    return remoteDataSource.cancelParticipation(matchId, request, token);
  }

  @override
  Future<Match> updateMatchResult(String matchId, Map<String, dynamic> request) async {
    final token = await _getToken();
    return remoteDataSource.updateMatchResult(matchId, request, token);
  }
}

