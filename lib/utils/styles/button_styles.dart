import 'package:flutter/material.dart';

ButtonStyle customOutlineStyle(){
   return ButtonStyle(
     shape: MaterialStatePropertyAll(RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10.0)
     ))
   );
}