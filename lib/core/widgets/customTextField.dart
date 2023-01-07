import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;

  final TextInputType textInputType;
  final bool obscureText;
  CustomTextField({
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5.0),
      height: 65,
      child: TextField(
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          errorStyle: TextStyle(color: Colors.white),
          filled: true,
        ),
      ),
    );
  }
}
