part of 'notifications_bloc.dart';

/// Abstract class for Notifications Event
abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

/// Fired when the app wants to get the notification list from the api
class GetNotifications extends NotificationsEvent {}
