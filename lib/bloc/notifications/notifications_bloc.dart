import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

/// BLoC implementation of notifications
///
/// This handles the list of notifications
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  /// The constructor defines what the app will do on:
  /// on<[GetNotifications]> when a GetNotifications is called gets the
  /// notifications from the api and marks them as received/read
  NotificationsBloc() : super(NotificationsInitial()) {
    on<GetNotifications>((event, emit) async {
      try {
        emit(NotificationsLoading());
        List<Notifica> notifications = await api.fetchNotificheByCF();
        notifications = notifications.where((n) => n.stato! <= 3).toList();
        emit(NotificationsLoaded(notifications));
        for (Notifica notifica in notifications) {
          if (notifica.stato != null && notifica.stato! <= 2) {
            api.readNotifica(notifica);
          }
        }
      } on ApiException catch (e) {
        emit(NotificationsError(e.msg));
      } catch (e) {
        emit(NotificationsError(e.toString()));
      }
    });
  }
}
