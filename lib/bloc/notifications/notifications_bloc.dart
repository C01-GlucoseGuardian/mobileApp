import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/notifica.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<GetNotifications>((event, emit) async {
      try {
        emit(NotificationsLoading());
        List<Notifica> notifications = await api
            .fetchNotificheByCF(SharedPreferenceService.codiceFiscale!);
        emit(NotificationsLoaded(notifications));
      } catch (e) {
        emit(NotificationsError(e.toString())); // TODO: better error message
      }
    });
  }
}
