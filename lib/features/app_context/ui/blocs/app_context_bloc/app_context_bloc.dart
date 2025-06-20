import "dart:convert";
import 'package:bloc/bloc.dart';

import '../../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../../leagues/domain/usecases/get_leagues_for_user.dart';

part 'app_context_event.dart';
part 'app_context_state.dart';

class AppContextBloc extends Bloc<AppContextEvent, AppContextState> {
  final AuthLocalDataSource localDataSource;
  final GetLeaguesForUser getLeaguesForUser;

  AppContextBloc({
    required this.localDataSource,
    required this.getLeaguesForUser,
  }) : super(AppContextInitial()) {
    on<AppContextStarted>(_onStarted);
  }

  Future<void> _onStarted(
      AppContextStarted event, Emitter<AppContextState> emit) async {
    emit(AppContextLoading());
    final tokens = await localDataSource.getTokens();
    if (tokens == null) {
      emit(AuthRequired());
      return;
    }
    final userId = _extractUserIdFromToken(tokens.accessToken);
    try {
      final leagues = await getLeaguesForUser(userId, tokens.accessToken);
      if (leagues.isEmpty) {
        emit(LeagueSelectionRequired());
      } else {
        emit(AppContextReady());
      }
    } catch (_) {
      emit(AuthRequired());
    }
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload =
        String.fromCharCodes(base64Url.decode(base64Url.normalize(parts[1])));
    final decoded = jsonDecode(payload) as Map<String, dynamic>;
    return decoded['sub'] as String;
  }
}
