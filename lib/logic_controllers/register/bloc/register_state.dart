part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucced extends RegisterState {
  final User user;
  const RegisterSucced({required this.user});
}

class RegisterFailed extends RegisterState {
  final String message;
  const RegisterFailed({required this.message});
}
