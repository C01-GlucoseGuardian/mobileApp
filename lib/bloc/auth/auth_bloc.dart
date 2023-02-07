import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<PerformLogin>((event, emit) async {
      try {
        emit(AuthLoading());

        final LoginOutput loginOutput = await api.performLogin(LoginInput(
          email: event.email,
          password: event.password,
        ));

        if ((loginOutput.needOtp ?? false)) {
          emit(AuthLoggedNeedsOtp());
          return;
        } else {
          emit(
            AuthLogged(
              loginOutput.token!,
              loginOutput.tipoUtente!,
              loginOutput.idUtente!,
            ),
          );
        }
      } on ApiException catch (e) {
        emit(AuthError(e.msg));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
