import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/models/user_model.dart';
import 'package:my_threads/utils/helper.dart';
import 'package:my_threads/utils/styles/button_styles.dart';
import 'package:my_threads/widgets/circle_image.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({ required this.user , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(top: 5),
        child: CircleImage(url: user.metadata?.image,),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: (){},
        style: customOutlineStyle(),
        child: Text("View Profile"),
      ),
      subtitle: Text(formatDateFromNow(user.createdAt!)),
    );
  }
}
