import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/login_response_model.dart';
import '../models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<UserModel> login(String email, String password, bool rememberMe) async {
    final LoginResponseModel response =
        await remoteDataSource.login(email, password);
    if (rememberMe) {
      await localDataSource.saveTokens(response.tokens);
    }
    return response.user;
  }

  @override
  Future<void> register(String email, String password) => remoteDataSource.register(email, password);

  @override
  Future<String> refreshToken(String refreshToken) => remoteDataSource.refreshToken(refreshToken);
}