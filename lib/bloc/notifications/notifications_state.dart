part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<Notifica> notifications;

  const NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String? error;

  const NotificationsError(this.error);
}
