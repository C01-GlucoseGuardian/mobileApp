import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial()) {
    on<GetAgenda>((event, emit) async {
      try {
        emit(AgendaLoading());
        List<AssunzioneFarmaco> agenda = await api.fetchAssunzioneFarmacoByCF(
            "CF"); // TODO: cf should be get by local db
        emit(AgendaLoaded(agenda));
      } catch (e) {
        emit(AgendaError(e.toString())); // TODO: better error message
      }
    });
  }
}
