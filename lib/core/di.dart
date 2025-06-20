import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_user.dart';
import '../features/auth/ui/blocs/auth_bloc/auth_bloc.dart';
import 'network/auth_api.dart';
import '../features/leagues/data/datasources/leagues_remote_datasource.dart';
import '../features/leagues/data/repositories/leagues_repository_impl.dart';
import '../features/leagues/domain/repositories/leagues_repository.dart';
import '../features/leagues/domain/usecases/get_leagues_for_user.dart';
import '../features/app_context/ui/blocs/app_context_bloc/app_context_bloc.dart';
import '../features/matches/data/datasources/matches_remote_datasource.dart';
import '../features/matches/data/repositories/matches_repository_impl.dart';
import '../features/matches/domain/repositories/matches_repository.dart';
import '../features/matches/domain/usecases/create_match.dart';
import '../features/matches/domain/usecases/get_match_details.dart';
import '../features/matches/domain/usecases/join_match.dart';
import '../features/matches/domain/usecases/cancel_participation.dart';
import '../features/matches/domain/usecases/update_match_result.dart';
import '../features/matches/ui/blocs/matches_bloc/matches_bloc.dart';
import 'network/token_refresher.dart';

final sl = GetIt.instance;

Future<void> init() async {
  const baseUrl = 'https://futmatch-api.onrender.com';
  // Http client
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // DataSources
    sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      client: sl(),
      baseUrl: baseUrl,
    ),
  );
  sl.registerLazySingleton<MatchesRemoteDataSource>(
    () => MatchesRemoteDataSourceImpl(
      client: sl(),
      baseUrl: baseUrl,
    ),
  );
  sl.registerLazySingleton<LeaguesRemoteDataSource>(
    () => LeaguesRemoteDataSourceImpl(
      client: sl(),
      baseUrl: baseUrl,
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl(), sl()),
  );

  // Token refresher
  sl.registerLazySingleton(
        () => TokenRefresher(repository: sl<AuthRepository>(), localDataSource: sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton<MatchesRepository>(
      () => MatchesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LeaguesRepository>(
      () => LeaguesRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => CreateMatch(sl()));
  sl.registerLazySingleton(() => GetMatchDetails(sl()));
  sl.registerLazySingleton(() => JoinMatch(sl()));
  sl.registerLazySingleton(() => CancelParticipation(sl()));
  sl.registerLazySingleton(() => UpdateMatchResult(sl()));
  sl.registerLazySingleton(() => GetLeaguesForUser(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(loginUser: sl<LoginUser>()));
  sl.registerFactory(() => MatchesBloc(
        createMatch: sl<CreateMatch>(),
        getMatchDetails: sl<GetMatchDetails>(),
        joinMatch: sl<JoinMatch>(),
        cancelParticipation: sl<CancelParticipation>(),
        updateMatchResult: sl<UpdateMatchResult>(),
      ));
  sl.registerFactory(() => AppContextBloc(
        localDataSource: sl<AuthLocalDataSource>(),
        getLeaguesForUser: sl<GetLeaguesForUser>(),
      ));
}