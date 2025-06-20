import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/league_model.dart';

abstract class LeaguesRemoteDataSource {
  Future<List<LeagueModel>> getLeaguesForUser(String userId, String token);
}

class LeaguesRemoteDataSourceImpl implements LeaguesRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  LeaguesRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<LeagueModel>> getLeaguesForUser(String userId, String token) async {
    final url = Uri.parse('$baseUrl/users/$userId/leagues');
    final response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception('Error al obtener ligas: ${response.body}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => LeagueModel.fromJson(e)).toList();
  }
}
