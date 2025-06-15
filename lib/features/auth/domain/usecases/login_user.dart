import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);

  Future<User> call(String email, String password, bool rememberMe) =>
      repository.login(email, password, rememberMe);
}