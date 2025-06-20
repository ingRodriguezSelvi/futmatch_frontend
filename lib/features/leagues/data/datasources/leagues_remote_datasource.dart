import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/league_model.dart';

abstract class LeaguesRemoteDataSource {
  Future<List<LeagueModel>> getLeaguesForUser(String userId, String token);
  Future<LeagueModel> createLeague(
      Map<String, dynamic> request, String token);
  Future<LeagueModel> joinLeague(
      String leagueId, Map<String, dynamic> request, String token);
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

  @override
  Future<LeagueModel> createLeague(
      Map<String, dynamic> request, String token) async {
    final url = Uri.parse('$baseUrl/leagues');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al crear liga: ${response.body}');
    }
    return LeagueModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<LeagueModel> joinLeague(
      String leagueId, Map<String, dynamic> request, String token) async {
    final url = Uri.parse('$baseUrl/leagues/$leagueId/join');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al unirse a la liga: ${response.body}');
    }
    return LeagueModel.fromJson(jsonDecode(response.body));
  }
}
