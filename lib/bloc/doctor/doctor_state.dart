part of 'doctor_bloc.dart';

/// Abstract state class that the bloc will emit when an action has been
/// performed
abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

/// Emitted on initial state of the bloc
class DoctorInitial extends DoctorState {}

/// Emitted when the bloc is loading something
class DoctorLoading extends DoctorState {}

/// Emitted when the bloc has loaded data
class DoctorLoaded extends DoctorState {
  /// The data
  final Dottore dottore;

  /// Constructor with [DoctorLoaded.agenda]
  const DoctorLoaded(this.dottore);
}

/// Emitted when something went wrong
class DoctorError extends DoctorState {
  /// The error message
  final String? error;

  /// Constructor with [AgendaError.error]
  const DoctorError(this.error);
}
