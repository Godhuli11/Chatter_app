import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/utils/helper.dart';

import '../models/post_model.dart';

class PostTopBar extends StatelessWidget {

  final PostModel post;

  const PostTopBar({required this.post , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(post.user!.metadata!.name! ,
          style: TextStyle(fontWeight: FontWeight.bold),),
        Row(
          children: [
            Text(formatDateFromNow(post.createdAt!)),
            SizedBox(width: 10,),
            Icon(Icons.more_horiz)
          ],
        )
      ],
    );
  }
}
