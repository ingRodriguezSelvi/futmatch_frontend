import '../../domain/entities/league.dart';
import '../../domain/repositories/leagues_repository.dart';
import '../datasources/leagues_remote_datasource.dart';

class LeaguesRepositoryImpl implements LeaguesRepository {
  final LeaguesRemoteDataSource remoteDataSource;

  LeaguesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<League>> getLeaguesForUser(String userId, String token) =>
      remoteDataSource.getLeaguesForUser(userId, token);
}
