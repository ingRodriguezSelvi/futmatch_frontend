import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../domain/entities/league.dart';
import '../../../domain/usecases/create_league.dart';
import '../../../domain/usecases/join_league.dart';

part 'leagues_event.dart';
part 'leagues_state.dart';

class LeaguesBloc extends Bloc<LeaguesEvent, LeaguesState> {
  final CreateLeague createLeague;
  final JoinLeague joinLeague;
  final AuthLocalDataSource localDataSource;

  LeaguesBloc({
    required this.createLeague,
    required this.joinLeague,
    required this.localDataSource,
  }) : super(LeaguesInitial()) {
    on<CreateLeagueRequested>(_onCreate);
    on<JoinLeagueRequested>(_onJoin);
  }

  Future<void> _onCreate(
      CreateLeagueRequested event, Emitter<LeaguesState> emit) async {
    emit(LeaguesLoading());
    try {
      final tokens = await localDataSource.getTokens();
      if (tokens == null) throw Exception('Sesión no encontrada');
      final userId = _extractUserIdFromToken(tokens.accessToken);
      final league = await createLeague(
        {'name': event.name, 'createdBy': userId},
        tokens.accessToken,
      );
      emit(LeagueLoaded(league));
    } catch (e) {
      emit(LeaguesError(e.toString()));
    }
  }

  Future<void> _onJoin(
      JoinLeagueRequested event, Emitter<LeaguesState> emit) async {
    emit(LeaguesLoading());
    try {
      final tokens = await localDataSource.getTokens();
      if (tokens == null) throw Exception('Sesión no encontrada');
      final userId = _extractUserIdFromToken(tokens.accessToken);
      final league = await joinLeague(
        event.leagueId,
        {'userId': userId},
        tokens.accessToken,
      );
      emit(LeagueLoaded(league));
    } catch (e) {
      emit(LeaguesError(e.toString()));
    }
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final decoded = jsonDecode(payload) as Map<String, dynamic>;
    return decoded['sub'] as String;
  }
}
