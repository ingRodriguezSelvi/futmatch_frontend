import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/player_model.dart';

abstract class PlayersRemoteDataSource {
  Future<PlayerModel> getCurrentPlayer(String userId, String token);
}

class PlayersRemoteDataSourceImpl implements PlayersRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  PlayersRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<PlayerModel> getCurrentPlayer(String userId, String token) async {
    final url = Uri.parse('$baseUrl/users/$userId/player');
    final response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception('Error al obtener jugador: ${response.body}');
    }
    return PlayerModel.fromJson(jsonDecode(response.body));
  }
}
