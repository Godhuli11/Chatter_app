
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/utils/helper.dart';

class CircleImage extends StatelessWidget {
  final double radius;
  final String? url;
  final File ? file;
  const CircleImage({this.radius = 20 ,this.url , this.file , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(file != null)
    CircleAvatar(
      backgroundImage: FileImage(file!),
      radius: radius,
    )
          else if(url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(gets3Url(url!)),
            radius: radius,
          )
         else
          CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
      ],
    );
  }
}
