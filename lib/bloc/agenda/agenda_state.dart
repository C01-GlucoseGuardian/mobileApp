part of 'agenda_bloc.dart';

/// Abstract state class that the bloc will emit when an action has been
/// performed
abstract class AgendaState extends Equatable {
  const AgendaState();

  @override
  List<Object?> get props => [];
}

/// Emitted on initial state of the bloc
class AgendaInitial extends AgendaState {}

/// Emitted when the bloc is loading something
class AgendaLoading extends AgendaState {}

/// Emitted when the bloc has loaded data
class AgendaLoaded extends AgendaState {
  /// The data list
  final List<AssunzioneFarmaco> agenda;

  /// Constructor with [AgendaLoaded.agenda]
  const AgendaLoaded(this.agenda);
}

/// Emitted when something went wrong
class AgendaError extends AgendaState {
  /// The error message
  final String? error;

  /// Constructor
  const AgendaError(this.error);
}
