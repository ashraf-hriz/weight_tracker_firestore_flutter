import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracher_task/repositories/user_repoditory.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is SignUpButtonPressed) {
        emit(RegisterLoading());
        try {
          var user = await userRepository.signUp(event.email, event.password);
          emit(RegisterSucced(user: user!));
        } catch (e) {
          emit(RegisterFailed(message: e.toString()));
        }
      }
    });
  }
}
