import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../domain/entities/league.dart';
import '../../../domain/usecases/create_league.dart';
import '../../../domain/usecases/join_league.dart';
import '../../../domain/usecases/get_leagues_for_user.dart';

part 'leagues_event.dart';
part 'leagues_state.dart';

class LeaguesBloc extends Bloc<LeaguesEvent, LeaguesState> {
  final CreateLeague createLeague;
  final JoinLeague joinLeague;
  final GetLeaguesForUser getLeaguesForUser;
  final AuthLocalDataSource localDataSource;

  final List<League> _leagues = [];
  League? _selectedLeague;

  List<League> get leagues => List.unmodifiable(_leagues);
  League? get selectedLeague => _selectedLeague;

  LeaguesBloc({
    required this.createLeague,
    required this.joinLeague,
    required this.getLeaguesForUser,
    required this.localDataSource,
  }) : super(LeaguesInitial()) {
    on<CreateLeagueRequested>(_onCreate);
    on<JoinLeagueRequested>(_onJoin);
    on<LoadLeaguesRequested>(_onLoad);
    on<SelectLeagueRequested>(_onSelect);
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
      _leagues.add(league);
      _selectedLeague = league;
      emit(LeagueLoaded(league));
      emit(LeaguesListLoaded(List.unmodifiable(_leagues), _selectedLeague));
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
      _leagues.add(league);
      _selectedLeague = league;
      emit(LeagueLoaded(league));
      emit(LeaguesListLoaded(List.unmodifiable(_leagues), _selectedLeague));
    } catch (e) {
      emit(LeaguesError(e.toString()));
    }
  }

  Future<void> _onLoad(
      LoadLeaguesRequested event, Emitter<LeaguesState> emit) async {
    emit(LeaguesLoading());
    try {
      final tokens = await localDataSource.getTokens();
      if (tokens == null) throw Exception('Sesión no encontrada');
      final userId = _extractUserIdFromToken(tokens.accessToken);
      final leagues = await getLeaguesForUser(userId, tokens.accessToken);
      _leagues
        ..clear()
        ..addAll(leagues);
      if (_leagues.isNotEmpty) {
        _selectedLeague = _leagues.first;
      }
      emit(LeaguesListLoaded(List.unmodifiable(_leagues), _selectedLeague));
    } catch (e) {
      emit(LeaguesError(e.toString()));
    }
  }

  void _onSelect(
      SelectLeagueRequested event, Emitter<LeaguesState> emit) {
    _selectedLeague = event.league;
    emit(LeaguesListLoaded(List.unmodifiable(_leagues), _selectedLeague));
  }

  String _extractUserIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final decoded = jsonDecode(payload) as Map<String, dynamic>;
    return decoded['sub'] as String;
  }
}
