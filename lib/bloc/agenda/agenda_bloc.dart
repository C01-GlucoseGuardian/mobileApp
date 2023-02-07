import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial()) {
    on<GetAgenda>((event, emit) async {
      try {
        emit(AgendaLoading());
        List<AssunzioneFarmaco> agenda = await api
            .fetchAssunzioneFarmacoByCF(SharedPreferenceService.codiceFiscale!);
        emit(AgendaLoaded(agenda));
      } on ApiException catch (e) {
        emit(AgendaError(e.msg));
      } catch (e) {
        emit(AgendaError(e.toString()));
      }
    });
  }
}
