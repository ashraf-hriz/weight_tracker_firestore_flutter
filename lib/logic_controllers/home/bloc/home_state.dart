part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class WeightAdded extends HomeState {}

class WeightFeild extends HomeState {}
