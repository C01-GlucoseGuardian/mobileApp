part of 'measurements_bloc.dart';

/// Abstract state class that the bloc will emit when an action has been
/// performed
abstract class MeasurementsState extends Equatable {
  const MeasurementsState();

  @override
  List<Object> get props => [];
}

/// Emitted on initial state of the bloc
class MeasurementsInitial extends MeasurementsState {}

/// Emitted when the bloc is loading something
class MeasurementsLoading extends MeasurementsState {}

/// Emitted when the bloc has loaded data
class MeasurementsLoaded extends MeasurementsState {
  /// The data list
  final List<Glicemia> measurements;

  /// constructor
  const MeasurementsLoaded(this.measurements);
}

/// Emitted when the bloc has loaded data
class SingleMeasurementLoaded extends MeasurementsState {
  /// the data loaded
  final Glicemia data;

  /// constructor
  const SingleMeasurementLoaded(this.data);
}

/// Emitted when something went wrong
class MeasurementsError extends MeasurementsState {
  /// The error message
  final String? error;

  /// Constructor
  const MeasurementsError(this.error);
}
