import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_threads/widgets/loading.dart';
import 'package:my_threads/widgets/search_input.dart';
import 'package:my_threads/widgets/user_tile.dart';

import '../../controllers/search_user_controller.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);



  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController textEditingController = TextEditingController(text: "");
  final SearchUserController controller = Get.put(SearchUserController());

  void searchUser(String? name) async {
    if(name != null){
            controller.searchUser(name);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: false,
            title: Text(
              "Search",
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
            ),
            expandedHeight: GetPlatform.isIOS ? 110 : 105,
            collapsedHeight: GetPlatform.isIOS ? 90 : 80,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                top: GetPlatform.isIOS ? 105 : 100, left : 10 , right: 10),
              child: SearchInput(
                controller: textEditingController,
                callback: searchUser,
              ),
              ),
            ),
          SliverToBoxAdapter(
            child: Obx(
                () => controller.loading.value ? Loading() : Column(
                  children: [
                    if(controller.users.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.users.length ,
                          itemBuilder: (context,index) =>
                              UserTile(user: controller.users[index]))
                    else if(controller.users.isEmpty && controller.notFound.value == true)
                       Text("No users found!")
                    else
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Search Users with their names."),
                        ),
                      )
                  ],
                )
            ),
          )
        ],
      ),
    );;
  }
}
