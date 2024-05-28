import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:my_threads/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/utils/helper.dart';
import 'package:my_threads/widgets/circle_image.dart';
import 'package:my_threads/widgets/post_card_bottom_bar.dart';
import 'package:my_threads/widgets/post_card_image.dart';
import 'package:my_threads/widgets/post_top_bar.dart';

class PostCard extends StatelessWidget {

  final PostModel post;

  const PostCard({ required this.post , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: context.width * 0.12,
                child: CircleImage(url: post.user?.metadata?.image,),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTopBar(post: post),
                    GestureDetector(
                      onTap: () => {
                        Get.toNamed(RouteNames.showThread , arguments: post.id),
                      },
                        child: Text(post.content!)),
                    SizedBox(height: 10,),
                    if(post.image != null)
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteNames.showImage,
                        arguments: post.image!);
                      },
                      child: PostCardImage(url: post.image!,) ,
                    ) ,
                     PostCardBottomBar(post: post),
                  ],
                ),
              )
            ],
          ),
          Divider(color: Color(0xff242424),)
        ],
      ),
    );
  }
}
