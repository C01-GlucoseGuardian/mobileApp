part of 'notifications_bloc.dart';

/// Abstract state class that the bloc will emit when an action has been
/// performed
abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

/// Emitted on initial state of the bloc
class NotificationsInitial extends NotificationsState {}

/// Emitted when the bloc is loading something
class NotificationsLoading extends NotificationsState {}

/// Emitted when the bloc has loaded data
class NotificationsLoaded extends NotificationsState {
  /// The data list
  final List<Notifica> notifications;

  /// Constructor
  const NotificationsLoaded(this.notifications);
}

/// Emitted when something went wrong
class NotificationsError extends NotificationsState {
  /// The error message
  final String? error;

  /// Constructor
  const NotificationsError(this.error);
}
