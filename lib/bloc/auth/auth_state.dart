part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogged extends AuthState {
  final String token;
  final int tipoUtente;
  final String codiceFiscale;

  const AuthLogged(this.token, this.tipoUtente, this.codiceFiscale);
}

class AuthLoggedNeedsOtp extends AuthState {}

class AuthError extends AuthState {
  final String? error;

  const AuthError(this.error);
}
