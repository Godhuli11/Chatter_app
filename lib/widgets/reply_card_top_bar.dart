import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/reply_model.dart';
import '../utils/helper.dart';

class ReplyCardTopBar extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCardTopBar({ required this.reply , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(reply.user!.metadata!.name! ,
          style: TextStyle(fontWeight: FontWeight.bold),),
        Row(
          children: [
            Text(formatDateFromNow(reply.createdAt!)),
            SizedBox(width: 10,),
            Icon(Icons.more_horiz)
          ],
        )
      ],
    );
  }
}
