import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/controllers/thread_controller.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/services/supabase_service.dart';
import '../models/post_model.dart';

class PostCardBottomBar extends StatefulWidget {
  final PostModel post;
  const PostCardBottomBar({ required this.post , Key? key}) : super(key: key);

  @override
  State<PostCardBottomBar> createState() => _PostCardBottomBarState();
}

class _PostCardBottomBarState extends State<PostCardBottomBar> {
  String likeStatus = "";
  final ThreadController controller = Get.find<ThreadController>();
  final SupaBaseService supaBaseService = Get.find<SupaBaseService>();

  void likeDislike(String status) async
  {
    setState(() {
      likeStatus = status;
    });
    
    
    await controller.likeDislike(status, widget.post.id!, widget.post.userId!,
    supaBaseService.currentUser.value!.id);
    
    
  } 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == 1 ? IconButton(onPressed: (){
              likeDislike("0");
            },
                icon: Icon(Icons.favorite , color: Colors.red[700],)):
            IconButton(onPressed: (){
              likeDislike("1");
            },
                icon: Icon(Icons.favorite_outline,)),
            IconButton(onPressed: (){
              Get.toNamed(RouteNames.addReply , arguments: widget.post);
            }, icon: Icon(Icons.chat_bubble_outline)),
            IconButton(onPressed: (){}, icon: Icon(Icons.send_outlined)),
          ],
        ),
        Row(
          children: [
            Text("${widget.post.commentCount} replies"),
            SizedBox(width: 10,),
            Text("${widget.post.likeCount} likes"),
          ],
        )
      ],
    );
  }
}
