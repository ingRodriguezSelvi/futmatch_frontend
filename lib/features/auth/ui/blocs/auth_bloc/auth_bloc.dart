import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../../core/di.dart';
import '../../../../core/network/token_refresher.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;

  AuthBloc({required this.loginUser}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user =
            await loginUser(event.email, event.password, event.rememberMe);
        if (event.rememberMe) {
          await sl<TokenRefresher>().start();
        }
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
