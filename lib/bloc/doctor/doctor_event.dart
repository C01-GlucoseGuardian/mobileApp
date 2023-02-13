part of 'doctor_bloc.dart';

/// Abstract class for Doctor events
abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

/// The event fired when the app wants to get the doctor
class GetDoctor extends DoctorEvent {
  /// Codice Fiscale of the patient associated with this doctor
  final String codiceFiscale;

  /// Constructor with [GetDoctor.codiceFiscale]
  const GetDoctor(this.codiceFiscale);
}
