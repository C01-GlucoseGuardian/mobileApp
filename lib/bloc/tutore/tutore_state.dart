part of 'tutore_bloc.dart';

abstract class TutoreState extends Equatable {
  const TutoreState();

  @override
  List<Object> get props => [];
}

class TutoreInitial extends TutoreState {}

class TutoreLoading extends TutoreState {}

class TutoreLoaded extends TutoreState {
  final Tutore tutore;

  const TutoreLoaded(this.tutore);
}

class TutoreError extends TutoreState {
  final String? error;

  const TutoreError(this.error);
}
