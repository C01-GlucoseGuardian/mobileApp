part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final Dottore dottore;

  const DoctorLoaded(this.dottore);
}

class DoctorError extends DoctorState {
  final String? error;

  const DoctorError(this.error);
}
