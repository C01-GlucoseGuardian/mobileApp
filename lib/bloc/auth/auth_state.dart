part of 'auth_bloc.dart';

/// Abstract state class that the bloc will emit when an action has been
/// performed
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Emitted on initial state of the bloc
class AuthInitial extends AuthState {}

/// Emitted when the bloc is loading something
class AuthLoading extends AuthState {}

/// Emitted when the bloc has detected a correct login
class AuthLogged extends AuthState {
  /// token returned from the api
  final String token;

  /// tipoUtente returned from the api
  final int tipoUtente;

  /// codice fiscale returned from the api
  final String codiceFiscale;

  /// Constructor with [AuthLogged.token], [AuthLogged.tipoUtente] and
  /// [AuthLogged.codiceFiscale]
  const AuthLogged(this.token, this.tipoUtente, this.codiceFiscale);
}

/// Emitted when the bloc has detected that the user has OTP login enabled
class AuthLoggedNeedsOtp extends AuthState {}

/// Emitted when something went wrong
class AuthError extends AuthState {
  /// The error message

  final String? error;

  /// Constructor with [AuthError.error]
  const AuthError(this.error);
}
