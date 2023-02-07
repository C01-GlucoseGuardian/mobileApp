import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'measurements_event.dart';
part 'measurements_state.dart';

class MeasurementsBloc extends Bloc<MeasurementsEvent, MeasurementsState> {
  MeasurementsBloc() : super(MeasurementsInitial()) {
    on<GetLast>((event, emit) async {
      try {
        emit(MeasurementsLoading());
        Glicemia glicemia =
            await api.fetchLastGlicemia(SharedPreferenceService.codiceFiscale!);
        emit(SingleMeasurementLoaded(glicemia));
      } catch (e) {
        emit(MeasurementsError(e.toString())); // TODO: better error message
      }
    });

    on<GetMeasurementsInRange>((event, emit) async {
      try {
        emit(MeasurementsLoading());
        int startTime = event.startTime;
        int endTime = event.endTime;

        List<Glicemia> measurements = await api.fetchGlicemiaInRange(
          SharedPreferenceService.codiceFiscale!,
          startTime,
          endTime,
        );
        emit(MeasurementsLoaded(measurements));
      } catch (e) {
        emit(MeasurementsError(e.toString())); // TODO: better error message
      }
    });
  }
}
