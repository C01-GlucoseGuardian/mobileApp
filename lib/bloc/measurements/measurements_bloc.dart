import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/constants/dates.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'measurements_event.dart';
part 'measurements_state.dart';

/// BLoC implementation of Glicemia
///
/// This handles the sending/receiving of glucose measurements
class MeasurementsBloc extends Bloc<MeasurementsEvent, MeasurementsState> {
  /// The constructor defines what the app will do on:
  /// on<[GetLast]> gets the last measurement from the api
  /// on<[GetMeasurementsInRange]> gets the measurements from the api in the
  /// selected range (timestamp)
  /// on<[AddGlicemia]> sends a new measurement to the server
  MeasurementsBloc() : super(MeasurementsInitial()) {
    on<GetLast>((event, emit) async {
      try {
        emit(MeasurementsLoading());
        Glicemia glicemia =
            await api.fetchLastGlicemia(SharedPreferenceService.codiceFiscale!);
        emit(SingleMeasurementLoaded(glicemia));
      } on ApiException catch (e) {
        emit(MeasurementsError(e.msg));
      } catch (e) {
        emit(MeasurementsError(e.toString()));
      }
    });

    on<GetMeasurementsInRange>((event, emit) async {
      await _getDataFromApi(emit, event);
    });

    on<AddGlicemia>((event, emit) async {
      await api.sendGlicemia(event.glicemia);

      await _getDataFromApi(emit, null);
    });
  }

  /// Gets data from API and the emits the state to the caller
  Future<void> _getDataFromApi(
      Emitter<MeasurementsState> emit, GetMeasurementsInRange? event) async {
    try {
      emit(MeasurementsLoading());
      int startTime = event != null
          ? event.startTime
          : getDayTimeSpan(DateTime.now())[0].millisecondsSinceEpoch;
      int endTime = event != null
          ? event.endTime
          : getDayTimeSpan(DateTime.now())[1].millisecondsSinceEpoch;

      List<Glicemia> measurements = await api.fetchGlicemiaInRange(
        event == null
            ? SharedPreferenceService.codiceFiscale!
            : (event.codiceFiscalePaziente ??
                SharedPreferenceService.codiceFiscale!),
        startTime,
        endTime,
      );

      measurements.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

      emit(MeasurementsLoaded(measurements));
    } on ApiException catch (e) {
      emit(MeasurementsError(e.msg));
    } catch (e) {
      emit(MeasurementsError(e.toString()));
    }
  }
}
