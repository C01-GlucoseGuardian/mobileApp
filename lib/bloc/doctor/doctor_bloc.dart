import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/dottore.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial()) {
    on<GetDoctor>((event, emit) async {
      try {
        emit(DoctorLoading());
        Dottore doctor = await api.fetchDottoreByPazienteCF(
            "CF"); // TODO: cf should be get by local db
        emit(DoctorLoaded(doctor));
      } catch (e) {
        emit(DoctorError(e.toString())); // TODO: better error message
      }
    });
  }
}
