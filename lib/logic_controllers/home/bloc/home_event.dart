part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddWeightEvent extends HomeEvent {
  final String weight;
  AddWeightEvent({required this.weight});
}
