import '../models/user.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
  Future<void> register(String email, String password);
  Future<String> refreshToken(String refreshToken);
}