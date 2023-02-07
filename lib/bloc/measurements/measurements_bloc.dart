import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/glicemia.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
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
      } on ApiException catch (e) {
        emit(MeasurementsError(e.msg));
      } catch (e) {
        emit(MeasurementsError(e.toString()));
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
      } on ApiException catch (e) {
        emit(MeasurementsError(e.msg));
      } catch (e) {
        emit(MeasurementsError(e.toString()));
      }
    });
  }
}
