import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_threads/views/home/home_page.dart';
import 'package:my_threads/views/notification/notifications.dart';
import 'package:my_threads/views/profile/profile.dart';
import 'package:my_threads/views/threads/add_threads.dart';

import '../views/search/search.dart';

class NavigationService extends GetxService{
   var currIndex = 0.obs;
   var prevIndex = 0.obs;

   //all pages
   List<Widget> pages(){
       return [
          HomePage(),
         const Search(),
          AddThread(),
         const Notifications(),
         const Profile(),
       ];
   }


   //update index
  void updateIndex(int index){
    prevIndex.value = currIndex.value;
    currIndex.value = index;
  }

  //back to prev page
   void backToPrevPage(){
     currIndex.value = prevIndex.value;
   }
}