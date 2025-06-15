import 'dart:async';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/auth_tokens_model.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

class TokenRefresher {
  final AuthRepository repository;
  final AuthLocalDataSource localDataSource;
  Timer? _timer;

  TokenRefresher({required this.repository, required this.localDataSource});

  Future<void> start() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 55), (_) async {
      final tokens = await localDataSource.getTokens();
      if (tokens == null) return;
      try {
        final newAccess = await repository.refreshToken(tokens.refreshToken);
        await localDataSource.saveTokens(
          AuthTokensModel(accessToken: newAccess, refreshToken: tokens.refreshToken),
        );
      } catch (_) {}
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
