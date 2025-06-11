import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> login(String email, String password) => remoteDataSource.login(email, password);

  @override
  Future<void> register(String email, String password) => remoteDataSource.register(email, password);

  @override
  Future<String> refreshToken(String refreshToken) => remoteDataSource.refreshToken(refreshToken);
}