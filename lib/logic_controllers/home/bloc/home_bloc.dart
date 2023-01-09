import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracher_task/core/error/failures.dart';
import 'package:weight_tracher_task/models/weight_model.dart';
import 'package:weight_tracher_task/repositories/weight_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeightRepository weightRepository;
  StreamSubscription? _todosSubscription;

  HomeBloc({required this.weightRepository}) : super(HomeInitial()) {
    /*on<HomeEvent>((event, emit) async {
      if (event is AddWeightEvent) {
        _addWeight(event , emit);
      }
      if (event is GetAllWeightsEvent) {}
    });*/
    on<AddWeightEvent>(_addWeight);
    on<LoadWeights>(_loadAllWeights);
    on<WeightsUpdated>(_weightsUpdated);
  }

  _addWeight(AddWeightEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingState());
      var result = await weightRepository.addNewWeight(event.weight);
      result.fold(
        (failure) {
          emit(WeightFailed(message: failure.message));
        },
        (_) {
          emit(WeightAdded());
        },
      );
    } catch (e) {
      print('weit err $e');
      emit(WeightFailed(message: e.toString()));
    }
  }

  _loadAllWeights(LoadWeights event, Emitter<HomeState> emit) {
    emit(LoadingState());
    _todosSubscription?.cancel();
    var result = weightRepository.weights();
    result.fold(
      (failure) => emit(WeightFailed(message: failure.message)),
      (weightsStream) {
        _todosSubscription = weightsStream.listen(
              (weights) {
                add(WeightsUpdated(weights: weights));
              },
        );
      },
    );

  }

  _weightsUpdated(WeightsUpdated event, Emitter<HomeState> emit){
    emit(WeightsLoaded(weights: event.weights));
  }
}
