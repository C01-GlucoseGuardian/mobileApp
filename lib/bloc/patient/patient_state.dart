part of 'patient_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object?> get props => [];
}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  final Paziente patient;

  const PatientLoaded(this.patient);
}

class PatientError extends PatientState {
  final String? error;

  const PatientError(this.error);
}
