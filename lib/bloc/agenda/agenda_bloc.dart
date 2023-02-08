import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/services/db/hive_assunzione_farmaco_service.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial()) {
    on<GetAgenda>((event, emit) async {
      try {
        emit(AgendaLoading());
        final List<AssunzioneFarmaco> storedData =
            await HiveAssunzioneFarmacoService.getAll();
        if (storedData.isNotEmpty) {
          emit(AgendaLoaded(storedData));
        } else {
          List<AssunzioneFarmaco> agenda = await api.fetchAssunzioneFarmacoByCF(
              event.codiceFiscalePaziente ??
                  SharedPreferenceService.codiceFiscale!);
          HiveAssunzioneFarmacoService.clearAndSaveAll(agenda);
          emit(AgendaLoaded(agenda));
        }
      } on ApiException catch (e) {
        emit(AgendaError(e.msg));
      } catch (e) {
        emit(AgendaError(e.toString()));
      }
    });

    on<SetFarmacoAsTaken>((event, emit) async {
      try {
        emit(AgendaLoading());
        final List<AssunzioneFarmaco> storedData =
            await HiveAssunzioneFarmacoService.getAll();
        if (storedData.isNotEmpty) {
          HiveAssunzioneFarmacoService.setAsRead(event.id);
          emit(AgendaLoaded(storedData));
        } else {
          throw Exception();
        }
      } on ApiException catch (e) {
        emit(AgendaError(e.msg));
      } catch (e) {
        emit(AgendaError(e.toString()));
      }
    });
  }
}
