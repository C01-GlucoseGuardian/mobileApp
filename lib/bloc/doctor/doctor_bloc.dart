import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/dottore.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
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
