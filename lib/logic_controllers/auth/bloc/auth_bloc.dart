import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../repositories/user_repoditory.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppLoaded) {
        try {
          var isSignedIn = await userRepository.isSignedIn();

          if (isSignedIn) {
            var user = await userRepository.getCurrentUser();
            emit(AuthenticateState(user: user!));
          } else {
            emit(UnAuthenticateState());
          }
        } catch (e) {
          emit(UnAuthenticateState());
        }
      }
      else if (event is SignOutEvent) {
        try {
          await userRepository.signOut();
          print('user ${userRepository.isSignedIn()}');
          emit(AuthInitial());
          emit(UnAuthenticateState());
        } catch (e) {
          print('out error $e');
        }
      }
    });
  }
}
