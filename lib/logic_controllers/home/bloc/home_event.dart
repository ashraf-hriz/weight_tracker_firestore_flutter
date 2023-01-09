part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddWeightEvent extends HomeEvent {
  final String weight;
  const AddWeightEvent({required this.weight});
}

class LoadWeights extends HomeEvent {}

class WeightsUpdated extends HomeEvent {
  final List<WeightModel> weights;

  const WeightsUpdated({required this.weights});

}
