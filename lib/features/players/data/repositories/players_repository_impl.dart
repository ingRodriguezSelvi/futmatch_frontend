import 'dart:convert';

import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/players_repository.dart';
import '../datasources/players_remote_datasource.dart';

class PlayersRepositoryImpl implements PlayersRepository {
  final PlayersRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  PlayersRepositoryImpl(this.remoteDataSource, this.localDataSource);

  Future<String> _getToken() async {
    final tokens = await localDataSource.getTokens();
    if (tokens == null) throw Exception('Usuario no autenticado');
    return tokens.accessToken;
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final decoded = jsonDecode(payload) as Map<String, dynamic>;
    return decoded['sub'] as String;
  }

  @override
  Future<Player> getCurrentPlayer() async {
    final token = await _getToken();
    final userId = _extractUserIdFromToken(token);
    return remoteDataSource.getCurrentPlayer(userId, token);
  }
}
