import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/utils/type_def.dart';

class AuthInput extends StatelessWidget {
  final String label , hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final ValidatorCallback validatorCallback;
  const AuthInput({
    Key? key ,
    required this.label ,
    required this.hintText,
    required this.controller,
    required this.validatorCallback,
    this.isPasswordField=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordField,
      controller: controller,
      validator: validatorCallback,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey ),
          ),
          label:  Text(label),
          hintText: hintText,
      ),
    );
  }
}
