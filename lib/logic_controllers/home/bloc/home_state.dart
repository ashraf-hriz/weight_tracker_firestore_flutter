part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class WeightAdded extends HomeState {}

class WeightsLoaded extends HomeState {
  final List<WeightModel> weights;
  const WeightsLoaded({required this.weights});
}
class WeightFailed extends HomeState {
  final String message;

  const WeightFailed({required this.message});

}

