import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracher_task/core/widgets/customTextField.dart';
import 'package:weight_tracher_task/logic_controllers/login/bloc/login_bloc.dart';
import 'package:weight_tracher_task/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSucced) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false);
        }
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomTextField(
                obscureText: false,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
                hintText: 'Email',
              ),
              CustomTextField(
                obscureText: true,
                textInputType: TextInputType.emailAddress,
                textEditingController: passwordController,
                hintText: 'Password',
              ),
              ElevatedButton.icon(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString()));
                },
                icon: Icon(Icons.add),
                label: Text("SignIn"),
              ),
            ],
          ),
        );
      },
    );
  }
}
