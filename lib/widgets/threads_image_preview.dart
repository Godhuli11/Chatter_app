import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/thread_controller.dart';
import 'package:get/get.dart';

class ThreadsImagePreview extends StatelessWidget {
   ThreadsImagePreview({Key? key}) : super(key: key);

  final ThreadController controller = Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              controller.image.value!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: CircleAvatar(
                backgroundColor: Colors.white38,
                child: IconButton(onPressed: (){
                  controller.image.value = null;
                },
                  icon: Icon(Icons.close),),
              ))
        ],
      ),
    );
  }
}
