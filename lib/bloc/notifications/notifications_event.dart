part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetNotifications extends NotificationsEvent {
  final String? codiceFiscalePaziente;

  const GetNotifications({this.codiceFiscalePaziente});
}
