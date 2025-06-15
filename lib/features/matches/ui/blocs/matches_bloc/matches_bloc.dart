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

  final List<Match> _matches = [];
  List<Match> get matches => List.unmodifiable(_matches);

  MatchesBloc({
    required this.createMatch,
    required this.getMatchDetails,
    required this.joinMatch,
    required this.cancelParticipation,
    required this.updateMatchResult,
  }) : super(MatchesInitial()) {
    on<LoadMatchesRequested>((event, emit) {
      emit(MatchesListLoaded(List.unmodifiable(_matches)));
    });

    on<CreateMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await createMatch(event.request);
        _matches.add(match);
        emit(MatchLoaded(match));
        emit(MatchesListLoaded(List.unmodifiable(_matches)));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<GetMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await getMatchDetails(event.matchId);
        final index = _matches.indexWhere((m) => m.id == match.id);
        if (index == -1) {
          _matches.add(match);
        } else {
          _matches[index] = match;
        }
        emit(MatchLoaded(match));
        emit(MatchesListLoaded(List.unmodifiable(_matches)));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<JoinMatchRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await joinMatch(event.matchId, event.request);
        final index = _matches.indexWhere((m) => m.id == match.id);
        if (index != -1) {
          _matches[index] = match;
        }
        emit(MatchLoaded(match));
        emit(MatchesListLoaded(List.unmodifiable(_matches)));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<CancelParticipationRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await cancelParticipation(event.matchId, event.request);
        final index = _matches.indexWhere((m) => m.id == match.id);
        if (index != -1) {
          _matches[index] = match;
        }
        emit(MatchLoaded(match));
        emit(MatchesListLoaded(List.unmodifiable(_matches)));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });

    on<UpdateResultRequested>((event, emit) async {
      emit(MatchesLoading());
      try {
        final match = await updateMatchResult(event.matchId, event.request);
        final index = _matches.indexWhere((m) => m.id == match.id);
        if (index != -1) {
          _matches[index] = match;
        }
        emit(MatchLoaded(match));
        emit(MatchesListLoaded(List.unmodifiable(_matches)));
      } catch (e) {
        emit(MatchesError(e.toString()));
      }
    });
  }
}
