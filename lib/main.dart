import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weight_tracher_task/core/constants.dart';
import 'package:weight_tracher_task/core/utils/app_theme.dart';
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
        BlocProvider(
          create: (context) => di.sl<HomeBloc>()..add(LoadWeights()),
        ),
      ],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        defaultThemeId: SchedulerBinding.instance?.window.platformBrightness ==
                Brightness.light
            ? LIGHT_MODE
            : DARK_MODE,
        themes: [
          AppTheme(
            id: LIGHT_MODE,
            data: MyAppTheme.lightTheme(),
            description: 'light theme',
          ),
          AppTheme(
            id: DARK_MODE,
            data: MyAppTheme.darkTheme(),
            description: 'dark theme',
          ),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext){
              return  MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeProvider.themeOf(themeContext).data,
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
              );
            },
          )

        ),
      ),
    );
  }
}
