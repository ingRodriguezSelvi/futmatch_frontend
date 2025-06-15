import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/match_model.dart';

abstract class MatchesRemoteDataSource {
  Future<MatchModel> createMatch(Map<String, dynamic> request);
  Future<MatchModel> getMatch(String matchId);
  Future<MatchModel> joinMatch(String matchId, Map<String, dynamic> request);
  Future<MatchModel> cancelParticipation(String matchId, Map<String, dynamic> request);
  Future<MatchModel> updateMatchResult(String matchId, Map<String, dynamic> request);
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  MatchesRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<MatchModel> createMatch(Map<String, dynamic> request) async {
    final url = Uri.parse('$baseUrl/matches');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al crear partido: ${response.body}');
    }
    return MatchModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<MatchModel> getMatch(String matchId) async {
    final url = Uri.parse('$baseUrl/matches/$matchId');
    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw Exception('Error al obtener partido: ${response.body}');
    }
    return MatchModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<MatchModel> joinMatch(String matchId, Map<String, dynamic> request) async {
    final url = Uri.parse('$baseUrl/matches/$matchId/join');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al unirse al partido: ${response.body}');
    }
    return MatchModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<MatchModel> cancelParticipation(String matchId, Map<String, dynamic> request) async {
    final url = Uri.parse('$baseUrl/matches/$matchId/cancel');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al cancelar participación: ${response.body}');
    }
    return MatchModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<MatchModel> updateMatchResult(String matchId, Map<String, dynamic> request) async {
    final url = Uri.parse('$baseUrl/matches/$matchId/result');
    final response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar resultado: ${response.body}');
    }
    return MatchModel.fromJson(jsonDecode(response.body));
  }
}
