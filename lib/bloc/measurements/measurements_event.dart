part of 'measurements_bloc.dart';

/// Abstract class for Measurements events
abstract class MeasurementsEvent extends Equatable {
  const MeasurementsEvent();

  @override
  List<Object> get props => [];
}

/// The event fired when the app wants to get the last event
class GetLast extends MeasurementsEvent {}

/// The event fired when the app wants to get measurements in a range of
/// timestamps
class GetMeasurementsInRange extends MeasurementsEvent {
  /// timestamp start time (millisecondsSinceEpoch)
  final int startTime;

  /// timestamp end time (millisecondsSinceEpoch)
  final int endTime;

  /// Codice fiscale of the patient, passed only by the tutore app section
  final String? codiceFiscalePaziente;

  /// Constructor
  const GetMeasurementsInRange(this.startTime, this.endTime,
      {this.codiceFiscalePaziente});
}

/// Event fired when the app wants to send a measurement to the server
class AddGlicemia extends MeasurementsEvent {
  /// The glicemia measured
  final Glicemia glicemia;

  /// Constructor
  const AddGlicemia(this.glicemia);
}
