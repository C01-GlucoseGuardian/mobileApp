import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/auth.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC implementation of the Auth phase
///
/// This handles login and login with otp
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// The constructor defines what the app will do on:
  /// on<[AuthEvent]> when the user wants to login, calls the api with
  /// the correct data gotten from the event that can be [PerformLogin] or
  /// [PerformLoginNeedsOtp]
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        LoginOutput loginOutput;
        if (event is PerformLogin) {
          loginOutput = await api.performLogin(LoginInput(
            email: event.email,
            password: event.password,
          ));
        } else if (event is PerformLoginNeedsOtp) {
          loginOutput = await api.performLoginOtp(LoginInput(
            email: event.email,
            password: event.password,
            otp: event.otp,
          ));
        } else {
          throw Exception("never");
        }

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
      } on NeedsOTPApiException {
        emit(AuthLoggedNeedsOtp());
      } on ApiException catch (e) {
        emit(AuthError(e.msg));
      }
    });
  }
}
