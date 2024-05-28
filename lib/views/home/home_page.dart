import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:my_threads/widgets/post_card.dart';

import '../../widgets/loading.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () => controller.fetchThreads(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Padding(
                    padding: EdgeInsets.only(top: 10),
                child: Image.asset("assets/images/logo.png",
                width: 40,
                height: 40,),),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                 child: Obx(()=>
                 controller.loading.value ? Loading () :
                 ListView.builder(
                   shrinkWrap: true,
                   padding: EdgeInsets.zero,
                   physics: BouncingScrollPhysics(),
                   itemCount: controller.posts.length,
                   itemBuilder: (context,index) =>
                   PostCard(post: controller.posts[index]),)),
              )
            ],
          ),
        ),),
    );
  }
}
