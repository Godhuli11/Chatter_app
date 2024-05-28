import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/utils/type_def.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final InputCallback callback;

  const SearchInput({
    required this.callback,
    required this.controller,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: callback,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search ,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Color(0xff242424),
        hintText: "Search user...",
        hintStyle: TextStyle( color:  Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,horizontal: 10
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
      ),
    );
  }
}
