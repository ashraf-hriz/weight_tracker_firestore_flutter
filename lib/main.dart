import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/auth/bloc/auth_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/home/bloc/home_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/login/bloc/login_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/register/bloc/register_bloc.dart';
import 'package:weight_tracher_task/screens/home_screen.dart';
import 'package:weight_tracher_task/screens/splash_screen.dart';
import 'dependency_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(AppLoaded()),
        ),
        BlocProvider(
          create: (context) => di.sl<RegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider(create: ((context) => di.sl<HomeBloc>())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is UnAuthenticateState) {
              print('notAuth');
              return SplashScreen();
            } else if (state is AuthenticateState) {
              return HomeScreen();
            }

            return Container();
          },
        ),
      ),
    );
  }
}
