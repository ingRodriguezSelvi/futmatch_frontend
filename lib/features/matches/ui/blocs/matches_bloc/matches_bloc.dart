import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/match.dart';
import '../../../domain/usecases/create_match.dart';
import '../../../domain/usecases/get_match_details.dart';
import '../../../domain/usecases/join_match.dart';
import '../../../domain/usecases/cancel_participation.dart';
import '../../../domain/usecases/update_match_result.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final CreateMatch createMatch;
  final GetMatchDetails getMatchDetails;
  final JoinMatch joinMatch;
  final CancelParticipation cancelParticipation;
  final UpdateMatchResult updateMatchResult;

  MatchesBloc({
    required this.createMatch,
    required this.getMatchDetails,
    required this.joinMatch,
    required this.cancelParticipation,
    required this.updateMatchResult,
  }) : super(MatchesInitial()) {
    on<CreateMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await createMatch(event.request);
        emit(MatchLoaded(match));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<GetMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await getMatchDetails(event.matchId);
        emit(MatchLoaded(match));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<JoinMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await joinMatch(event.matchId, event.request);
        emit(MatchLoaded(match));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<CancelParticipationRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await cancelParticipation(event.matchId, event.request);
        emit(MatchLoaded(match));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<UpdateResultRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await updateMatchResult(event.matchId, event.request);
        emit(MatchLoaded(match));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });
  }
}
