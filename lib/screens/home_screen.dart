import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracher_task/core/widgets/add_weight_dialog.dart';
import 'package:weight_tracher_task/logic_controllers/auth/bloc/auth_bloc.dart';
import 'package:weight_tracher_task/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('home'),
        ),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddWieghtWidget();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UnAuthenticateState) {
                    print('UnAuthenticateState e');
                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const SplashScreen()),
                        (route) => false);
                  }
                },
               builder:(context, state){
                  return ListTile(
                    title: const Text('Logout'),
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                    },
                  );
               }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
