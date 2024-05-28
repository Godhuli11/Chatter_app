import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_threads/models/post_model.dart';
import '../utils/helper.dart';

class PostCardImage extends StatelessWidget {
  final String url;

  const PostCardImage({required this.url ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(
      maxHeight: context.height * 0.60,
      maxWidth: context.width * 0.80,
    ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(gets3Url(url),
          fit:  BoxFit.cover,
          alignment: Alignment.topCenter,),
      ),);
  }
}
