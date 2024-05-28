import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/utils/helper.dart';

class ShowImage extends StatelessWidget {

  final String image = Get.arguments;

  ShowImage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(gets3Url(image),fit: BoxFit.contain,),
      ),
    );
  }
}
