import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracher_task/logic_controllers/auth/bloc/auth_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/home/bloc/home_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/login/bloc/login_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/register/bloc/register_bloc.dart';
import 'package:weight_tracher_task/repositories/user_repoditory.dart';
import 'package:weight_tracher_task/repositories/weight_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc
  sl.registerFactory(() => AuthBloc(userRepository: sl()));
  sl.registerFactory(() => RegisterBloc(userRepository: sl()));
  sl.registerFactory(() => LoginBloc(userRepository: sl()));
  sl.registerFactory(() => HomeBloc(weightRepository: sl()));
  //repository
  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => UserRepository(firebaseAuth: sl()));
  sl.registerLazySingleton(() => WeightRepository());
  //external
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
}
