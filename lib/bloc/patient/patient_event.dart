part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class GetPatient extends PatientEvent {
  final String? codiceFiscalePaziente;

  const GetPatient({this.codiceFiscalePaziente});
}
