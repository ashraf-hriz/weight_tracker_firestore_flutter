import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracher_task/core/utils/snack_bar_message.dart';
import 'package:weight_tracher_task/core/widgets/add_weight_dialog.dart';
import 'package:weight_tracher_task/logic_controllers/auth/bloc/auth_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/home/bloc/home_bloc.dart';
import 'package:weight_tracher_task/models/weight_model.dart';
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
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is WeightFailed) {
              SnackBarMessage.showErrorSnackBar(
                  message: state.message, context: context);
            }
            if (state is WeightAdded) {
              SnackBarMessage.showSuccessSnackBar(
                  message: 'weight added successfully', context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else if (state is WeightsLoaded) {
              List<WeightModel> weights = state.weights;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: weights.length,
                itemBuilder: (context, index) {
                  return Text(weights[index].title!);
                },
              );
            }
            return Container();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddWeightWidget();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                if (state is UnAuthenticateState) {
                  print('UnAuthenticateState e');
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      (route) => false);
                }
              }, builder: (context, state) {
                return ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
