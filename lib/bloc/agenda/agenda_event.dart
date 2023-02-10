part of 'agenda_bloc.dart';

abstract class AgendaEvent extends Equatable {
  const AgendaEvent();

  @override
  List<Object> get props => [];
}

class GetAgenda extends AgendaEvent {
  final String? codiceFiscalePaziente;

  const GetAgenda({this.codiceFiscalePaziente});
}

class SetFarmacoAsTaken extends AgendaEvent {
  final int id;

  const SetFarmacoAsTaken(this.id);
}
