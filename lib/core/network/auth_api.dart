import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/models/auth_tokens_model.dart';
import '../../features/auth/data/models/user.dart';


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final loginUrl = Uri.parse('$baseUrl/auth/login');

    final loginResponse = await client.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (loginResponse.statusCode != 200) {
      throw Exception('Error al hacer login: ${loginResponse.body}');
    }

    final tokens = AuthTokensModel.fromJson(jsonDecode(loginResponse.body));

    final userId = _extractUserIdFromToken(tokens.accessToken);

    final userUrl = Uri.parse('$baseUrl/auth/$userId');
    final userResponse = await client.get(
      userUrl,
      headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
    );

    if (userResponse.statusCode != 200) {
      throw Exception('Error al obtener usuario: ${userResponse.body}');
    }

    return UserModel.fromJson(jsonDecode(userResponse.body));
  }

  @override
  Future<void> register(String email, String password) async {
    final registerUrl = Uri.parse('$baseUrl/auth/register');

    final response = await client.post(
      registerUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar: ${response.body}');
    }
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    final refreshUrl = Uri.parse('$baseUrl/auth/refresh');

    final response = await client.post(
      refreshUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al refrescar token: ${response.body}');
    }

    final body = jsonDecode(response.body);
    return body['accessToken'];
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final decoded = jsonDecode(payload);
    return decoded['sub'];
  }
}
