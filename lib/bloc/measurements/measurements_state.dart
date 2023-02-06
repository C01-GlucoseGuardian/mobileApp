part of 'measurements_bloc.dart';

abstract class MeasurementsState extends Equatable {
  const MeasurementsState();

  @override
  List<Object> get props => [];
}

class MeasurementsInitial extends MeasurementsState {}

class MeasurementsLoading extends MeasurementsState {}

class MeasurementsLoaded extends MeasurementsState {
  final List<Glicemia> measurements;

  const MeasurementsLoaded(this.measurements);
}

class SingleMeasurementLoaded extends MeasurementsState {
  final Glicemia data;

  const SingleMeasurementLoaded(this.data);
}

class MeasurementsError extends MeasurementsState {
  final String? error;

  const MeasurementsError(this.error);
}
