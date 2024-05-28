import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/controllers/thread_controller.dart';
import 'package:my_threads/widgets/post_card_image.dart';
import 'package:my_threads/widgets/reply_card.dart';

import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({Key? key}) : super(key: key);

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final ThreadController controller = Get.put(ThreadController());

  @override
  void initState(){

    controller.show(postId);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Threads"),
      ),
      body:
      Obx( () => controller.showThreadLoading.value ? Loading() : SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
                 PostCard(post: controller.post.value,),
               SizedBox(height: 10,),

              //Load post replies
              if(controller.showReplyLoading.value)
                   Loading()
              else if(controller.replies.isNotEmpty)
                ListView.builder(
                   itemCount: controller.replies.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index) => ReplyCard(
                        reply: controller.replies[index]))
              else
                Center(
                  child: Text("No replies"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
