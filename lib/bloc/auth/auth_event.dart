part of 'auth_bloc.dart';

/// Abstract class for Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// This event is fired when the user wants to login with only email and
/// password, it will return [AuthLogged] if logged correctly or
/// [AuthLoggedNeedsOtp] if a otp code is called
class PerformLogin extends AuthEvent {
  /// email
  final String email;

  /// password
  final String password;

  /// Constructor with [PerformLoginNeedsOtp.email] and
  /// [PerformLoginNeedsOtp.password]
  const PerformLogin(this.email, this.password);
}

/// This event will be fired when we already tried to login with only email
/// and password and we got a [AuthLoggedNeedsOtp]
class PerformLoginNeedsOtp extends AuthEvent {
  /// email
  final String email;

  /// password
  final String password;

  /// otp code
  final String otp;

  /// Constructor with [PerformLoginNeedsOtp.email],
  /// [PerformLoginNeedsOtp.password] and [PerformLoginNeedsOtp.otp]
  const PerformLoginNeedsOtp(this.email, this.password, this.otp);
}
