
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/controllers/profile_controller.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/utils/styles/button_styles.dart';
import 'package:my_threads/widgets/circle_image.dart';
import 'package:my_threads/widgets/reply_card.dart';
import 'package:my_threads/widgets/post_card.dart';

import '../../widgets/loading.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller = Get.put(ProfileController());
  final SupaBaseService supabaseService = Get.find<SupaBaseService>();

   @override
   void initState(){
     if(supabaseService.currentUser.value?.id != null){
       controller.fetchUserThreads(supabaseService.currentUser.value!.id);
       controller.fetchReplies(supabaseService.currentUser.value!.id);
     }
     super.initState();
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.language),
        centerTitle: false,
        actions: [
          IconButton(onPressed: ()=>Get.toNamed(RouteNames.settings), icon: const Icon(Icons.sort))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
          (context,innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
               expandedHeight: 160,
                collapsedHeight: 160,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Obx(
                               () => Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     supabaseService.currentUser.value?.userMetadata?["name"] ?? "Default name",
                                     style: TextStyle(
                                       fontSize: 25,
                                       fontWeight: FontWeight.bold
                                     ) ,),
                                   SizedBox(
                                     width: context.width * 0.70,
                                       child: Text(supabaseService.currentUser.value?.userMetadata?["description"]??
                                           "Let's build a redefined threads app.")),

                                 ],
                               ),
                             ),
                             CircleImage(
                               radius: 40,
                               url: supabaseService.currentUser.value?.userMetadata?["image"],
                             )
                           ],
                         ),
                         const SizedBox(height: 20,),
                         Row(
                           children: [
                             Expanded(child: OutlinedButton(
                               onPressed: ()=>Get.toNamed(RouteNames.editProfile),
                               style: customOutlineStyle(),
                               child: const Text("Edit profile"),
                             )),
                             const SizedBox(width: 20,),
                             Expanded(child: OutlinedButton(
                               onPressed: (){},
                               style: customOutlineStyle(),
                               child: const Text("Share profile"),
                             )),
                           ],
                         )
                       ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                  pinned: true,
                  delegate: SliverAppBarDelegate(const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                      tabs:[
                Tab(text: "Threads",),
                Tab(text: "Replies",),
              ])))
            ];
          },
          body: TabBarView(
            children: [
              Obx(() => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox( height: 10,),
                    if(controller.postLoading.value)
                      Loading()
                    else if(controller.posts.isNotEmpty)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context,index) => PostCard(
                            post: controller.posts[index],))
                    else
                      Center(
                        child: Text("No thread found!"),
                      )
                  ],
                ),
              )),
              Obx(() => SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    if(controller.replyLoading.value)
                       Loading()
                    else if(controller.replies.isNotEmpty)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                        itemCount: controller.replies.length,
                   itemBuilder: (context,index)=>ReplyCard(reply:
                     controller.replies[index],))
                     else
                      Center(
                      child: Text("No thread found!"),
                      )
                  ],
                ),
              ))
            ],
          ),
        ),
      )
    );;
  }
}


//Sliver Persistent Header class
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate{

  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override

  double get maxExtent => _tabBar.preferredSize.height;

  @override

  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }



  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}