
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/controllers/reply_controller.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/widgets/circle_image.dart';
import 'package:my_threads/widgets/post_card_image.dart';
import '../../models/post_model.dart';

class AddReply extends StatelessWidget {
   AddReply({Key? key}) : super(key: key);
  final PostModel post = Get.arguments;
  final ReplyController controller = Get.put(ReplyController());
  final SupaBaseService supaBaseService = Get.find<SupaBaseService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.close)),
        title: Text("Reply"),
        actions: [
          Obx(
          () => TextButton(onPressed: (){
              if(controller.reply.isNotEmpty){
                controller.addReply(supaBaseService.currentUser.value!.id, post.id!, post.userId!);
              }
            }, child: controller.loading.value ? SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(),
          ) : Text("Reply" , style: TextStyle(
            fontWeight: controller.reply.isNotEmpty ? FontWeight.bold : FontWeight.normal
          ),)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width * 0.12,
                    child: CircleImage(
                      url: post.user?.metadata?.image,
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.user!.metadata!.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(post.content!),
                        SizedBox(height: 10,),
                        if(post.image != null ) PostCardImage(url: post.image!),

                        //Reply Field
                        TextField(
                          autofocus: true,
                          controller: controller.replyController,
                          onChanged: (value) => controller.reply.value = value,
                          style: TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: InputDecoration(
                            hintText: "Type a reply",
                            border: InputBorder.none,
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
