import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

/// BLoC implementation of the Doctor
///
/// This handles when the user wants to see the profile of their doctor, or
/// when the tutore wants to se the doctor associated with their patient
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  /// The constructor defines what the app will do on:
  /// on<[GetDoctor]> when a GetDoctor event is fired gets the data from the
  /// api and emits a [DoctorLoaded] state with the data
  DoctorBloc() : super(DoctorInitial()) {
    on<GetDoctor>((event, emit) async {
      try {
        emit(DoctorLoading());
        Dottore doctor =
            await api.fetchDottoreByPazienteCF(event.codiceFiscale);
        emit(DoctorLoaded(doctor));
      } on ApiException catch (e) {
        emit(DoctorError(e.msg));
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
  }
}
