import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(String email, String password);
  Future<String> refreshToken(String refreshToken);
}