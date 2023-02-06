part of 'measurements_bloc.dart';

abstract class MeasurementsEvent extends Equatable {
  const MeasurementsEvent();

  @override
  List<Object> get props => [];
}

class GetLast extends MeasurementsEvent {}

class GetMeasurementsInRange extends MeasurementsEvent {
  final int startTime;
  final int endTime;

  const GetMeasurementsInRange(this.startTime, this.endTime);
}
