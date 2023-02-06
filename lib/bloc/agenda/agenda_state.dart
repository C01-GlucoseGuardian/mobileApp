part of 'agenda_bloc.dart';

abstract class AgendaState extends Equatable {
  const AgendaState();

  @override
  List<Object?> get props => [];
}

class AgendaInitial extends AgendaState {}

class AgendaLoading extends AgendaState {}

class AgendaLoaded extends AgendaState {
  final List<AssunzioneFarmaco> agenda;

  const AgendaLoaded(this.agenda);
}

class AgendaError extends AgendaState {
  final String? error;

  const AgendaError(this.error);
}
