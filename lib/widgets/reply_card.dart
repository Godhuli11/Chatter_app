import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/widgets/circle_image.dart';
import 'package:my_threads/widgets/reply_card_top_bar.dart';
import '../models/reply_model.dart';

class ReplyCard extends StatelessWidget {

  final ReplyModel reply;
  const ReplyCard({ required this.reply , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(
                url: reply.user?.metadata?.image,
              ),
            ),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReplyCardTopBar(reply: reply),
                  Text(reply.reply!)
                ],
              ),
            )
          ],
        ),
        Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
