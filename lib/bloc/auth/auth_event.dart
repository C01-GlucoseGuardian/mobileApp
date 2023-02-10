part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class PerformLogin extends AuthEvent {
  final String email;
  final String password;

  const PerformLogin(this.email, this.password);
}

class PerformLoginNeedsOtp extends AuthEvent {
  final String email;
  final String password;
  final String otp;

  const PerformLoginNeedsOtp(this.email, this.password, this.otp);
}
