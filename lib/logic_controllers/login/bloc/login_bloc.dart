import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracher_task/repositories/user_repoditory.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          var user = await userRepository.signIn(event.email, event.password);
          emit(LoginSucced(user: user!));
        } catch (e) {
          emit(LoginFailed(message: e.toString()));
        }
      }
    });
  }
}
