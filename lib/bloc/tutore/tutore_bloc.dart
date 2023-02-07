import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glucose_guardian/bloc/common.dart';
import 'package:glucose_guardian/models/tutore.dart';
import 'package:glucose_guardian/services/exceptions/api_exception.dart';
import 'package:glucose_guardian/services/shared_preferences_service.dart';

part 'tutore_event.dart';
part 'tutore_state.dart';

class TutoreBloc extends Bloc<TutoreEvent, TutoreState> {
  TutoreBloc() : super(TutoreInitial()) {
    on<GetTutore>((event, emit) async {
      try {
        emit(TutoreLoading());
        Tutore tutore =
            await api.fetchLoggedTutore(SharedPreferenceService.codiceFiscale!);
        emit(TutoreLoaded(tutore));
      } on ApiException catch (e) {
        emit(TutoreError(e.msg));
      } catch (e) {
        emit(TutoreError(e.toString()));
      }
    });
  }
}
