import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracher_task/repositories/weight_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeightRepository weightRepository;
  HomeBloc({required this.weightRepository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is AddWeightEvent) {
        try {
          emit(LoadingState());
          await weightRepository.addNewWeight(event.weight);
          emit(WeightAdded());
        } catch (e) {
          print('weit err $e');
          emit(WeightFeild());
        }
      }
    });
  }
}
