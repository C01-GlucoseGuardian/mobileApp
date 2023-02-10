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
  final String? codiceFiscalePaziente;

  const GetMeasurementsInRange(this.startTime, this.endTime,
      {this.codiceFiscalePaziente});
}

class AddGlicemia extends MeasurementsEvent {
  final Glicemia glicemia;

  const AddGlicemia(this.glicemia);
}
