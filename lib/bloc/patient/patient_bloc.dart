import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/paziente.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientInitial()) {
    on<GetPatient>((event, emit) async {
      try {
        emit(PatientLoading());
        Paziente patient = await api
            .fetchLoggedPaziente(SharedPreferenceService.codiceFiscale!);
        emit(PatientLoaded(patient));
      } on ApiException catch (e) {
        emit(PatientError(e.msg));
      } catch (e) {
        emit(PatientError(e.toString()));
      }
    });
  }
}
