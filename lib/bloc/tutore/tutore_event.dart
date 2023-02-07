part of 'tutore_bloc.dart';

abstract class TutoreEvent extends Equatable {
  const TutoreEvent();

  @override
  List<Object> get props => [];
}

class GetTutore extends TutoreEvent {}
