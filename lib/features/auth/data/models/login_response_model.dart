import 'user.dart';
import 'auth_tokens_model.dart';

class LoginResponseModel {
  final UserModel user;
  final AuthTokensModel tokens;
  LoginResponseModel({required this.user, required this.tokens});
}
