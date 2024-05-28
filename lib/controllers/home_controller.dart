import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:my_threads/models/post_model.dart';
import 'package:my_threads/services/supabase_service.dart';



class HomeController extends GetxController{

   var loading = false.obs;

   RxList<PostModel> posts = RxList<PostModel>();


   @override
   void onInit() async{
     await fetchThreads();
     super.onInit();
   }

    Future<void> fetchThreads() async {
        loading.value = true;
        final List<dynamic> response = await SupaBaseService.client.from("posts").select(
          '''
          id,content,image,created_at,comment_count,like_count,user_id,
          user:user_id (email,metadata),likes : likes(user_id,post_id)
        ''').order("id",ascending: false);
        print("The threads res ${jsonEncode(response)}");
        loading.value = false;
        if(response.isNotEmpty){
          posts.value = [for(var item in response) PostModel.fromJson(item)];
        }
    }

    //Listen to RealTime Thread changes
   void listenChanges() async
   {
     SupaBaseService.client.channel('public:posts').on(
       RealtimeListenTypes.postgresChanges,
       
     )
   }

}