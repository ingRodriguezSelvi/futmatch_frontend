import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/login_response_model.dart';
import '../models/user.dart';
import '../models/auth_tokens_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<UserModel> login(String email, String password, bool rememberMe) async {
    final LoginResponseModel response =
        await remoteDataSource.login(email, password);
    // Always update persisted tokens to avoid discrepancies
    await localDataSource.saveTokens(response.tokens);
    return response.user;
  }

  @override
  Future<void> register(String email, String password) => remoteDataSource.register(email, password);

  @override
  Future<String> refreshToken(String refreshToken) async {
    final newAccess = await remoteDataSource.refreshToken(refreshToken);
    // Persist the refreshed access token alongside the current refresh token
    await localDataSource
        .saveTokens(AuthTokensModel(accessToken: newAccess, refreshToken: refreshToken));
    return newAccess;
  }
}