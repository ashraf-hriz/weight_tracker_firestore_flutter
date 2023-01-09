import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracher_task/logic_controllers/home/bloc/home_bloc.dart';

class AddWeightWidget extends StatefulWidget {
  const AddWeightWidget({Key? key}) : super(key: key);

  @override
  State<AddWeightWidget> createState() => _AddWeightWidgetState();
}

class _AddWeightWidgetState extends State<AddWeightWidget> {
  TextEditingController weightTextCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          const Text(
            "Add Weight",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      children: [
        const Divider(),
        TextFormField(
          controller: weightTextCtr,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
            color: Colors.white,
          ),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "eg. 145 k.g",
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: width,
          height: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("Add"),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              if (weightTextCtr.text.isNotEmpty) {
                /* await DatabaseService()
                    .createNewTodo(todoTitleController.text.trim()); */
                BlocProvider.of<HomeBloc>(context)
                    .add(AddWeightEvent(weight: weightTextCtr.text.toString()));
                Navigator.pop(context);
              }
            },
          ),
        )
      ],
    );
  }
}
