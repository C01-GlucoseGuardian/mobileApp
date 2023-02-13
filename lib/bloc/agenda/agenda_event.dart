part of 'agenda_bloc.dart';

/// Abstract class for Agenda Events
abstract class AgendaEvent extends Equatable {
  const AgendaEvent();

  @override
  List<Object> get props => [];
}

/// The event fired when the app wants to get the whole AssunzioneFarmaco list
/// from the api
class GetAgenda extends AgendaEvent {
  /// Codice fiscale is passed only on tutore app
  final String? codiceFiscalePaziente;

  /// Constructor with [GetAgenda.codiceFiscalePaziente]
  const GetAgenda({this.codiceFiscalePaziente});
}

/// Event fired when the app wants to set a farmaco as taken
class SetFarmacoAsTaken extends AgendaEvent {
  /// id of the farmaco
  final int id;

  /// Constructor with [SetFarmacoAsTaken.id]
  const SetFarmacoAsTaken(this.id);
}
