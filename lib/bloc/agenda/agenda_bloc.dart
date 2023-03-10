import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/assunzione_farmaco.dart';
import 'package:glucose_guardian/services/db/hive_assunzione_farmaco_service.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

/// BLoC implementation of the Agenda
///
/// This handles the list of assunzioneFarmaco to be shown on the Agenda
/// section of the app
class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  /// The constructor defines what the app will do on:
  /// on<[GetAgenda]> when a getAgenda event is fired gets the data from the api
  /// and emits a [AgendaLoaded] state with the data
  ///
  /// on<[SetFarmacoAsTaken]> sets assunzioneFarmaco as taken on the hivedb and
  /// sends back the updated list
  AgendaBloc() : super(AgendaInitial()) {
    on<GetAgenda>((event, emit) async {
      try {
        emit(AgendaLoading());
        final List<AssunzioneFarmaco> storedData =
            await HiveAssunzioneFarmacoService.getAll();
        if (HiveAssunzioneFarmacoService.isValid() && storedData.isNotEmpty) {
          emit(AgendaLoaded(storedData));
        } else {
          List<AssunzioneFarmaco> agenda = await api.fetchAssunzioneFarmacoByCF(
              event.codiceFiscalePaziente ??
                  SharedPreferenceService.codiceFiscale!);
          HiveAssunzioneFarmacoService.clearAndSaveAll(agenda);
          emit(AgendaLoaded(agenda.toSet().toList()));
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
        if (HiveAssunzioneFarmacoService.isValid() && storedData.isNotEmpty) {
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
