import '../models/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(String email, String password);
  Future<String> refreshToken(String refreshToken);
}