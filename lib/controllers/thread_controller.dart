import 'dart:io';
import 'package:my_threads/services/navigation_service.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_threads/utils/helper.dart';

import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../utils/env.dart';

class ThreadController extends GetxController{
    final TextEditingController textEditingController =
        TextEditingController(text: "");

    var content = "".obs;
    var loading = false.obs;
    Rx<File?> image = Rx<File?>(null);

    var showThreadLoading = false.obs;
    Rx<PostModel> post = Rx<PostModel>(PostModel());

    var showReplyLoading = false.obs;
    RxList<ReplyModel> replies = RxList<ReplyModel>();

    void pickImage() async {
      File? file = await pickImageFromGallery();
      if(file != null){
        image.value = file;
      }
}

void store(String userId) async{
      try{

        loading.value = true;
        const uuid = Uuid();
        final dir = "$userId/${uuid.v6()}";
        var imgPath = "";

        if(image.value != null && image.value!.existsSync()){
          imgPath = await SupaBaseService.client.storage.from(ENV.s3Bucket).upload(dir, image.value!);
        }

        //Add post in DB
        await SupaBaseService.client.from("posts").insert({
           "user_id":userId,
            "content" :content.value,
          "image":imgPath.isNotEmpty ? imgPath : null
        });

        loading.value = false;
        resetState();
        Get.find<NavigationService>().currIndex.value = 0;
       showSnackBar("Success", "Threaded Added Successfully");
      } on StorageException catch(error){
            loading.value = false;
            showSnackBar("Error", error.message);
      } catch (error){
        loading.value = false;
        showSnackBar("Error", "Something went wrong.!");
      }
}

//To show post/thread
  void show(int postId) async{
      try{
        post.value = PostModel();
        replies.value = [];
        showThreadLoading.value = true;
        final response = await SupaBaseService.client.from("posts").select(
            '''
          id,content,image,created_at,comment_count,like_count,user_id,
          user:user_id (email,metadata)
        '''
        ).eq("id",postId).single();
        showThreadLoading.value = false;
        post.value = PostModel.fromJson(response);

        //Fetch Replies
        fetchPostReplies(postId);
      } catch(e){
           showThreadLoading.value = false;
           showSnackBar("Error", "Something went wrong!");
      }

  }

  //Fetch Post Replies
  void fetchPostReplies(int postId) async {
       try{
         showReplyLoading.value = true;
         final List<dynamic> response =
         await SupaBaseService.client.from("comments").select(
             ''' id,user_id,post_id,reply,created_at,user:user_id(email,metadata)
          ''').eq("post_id",postId);
         showReplyLoading.value = false;
         if(response.isNotEmpty){
           replies.value = [for(var item in response) ReplyModel.fromJson(item)];
         }
       }catch(e){
         showReplyLoading.value = false;
         showSnackBar("Error", "Something went wrong!");
       }
  }


  //to like and dislike
  Future<void> likeDislike(String status , int postId , String postUserId , String userId) async {
    if (status == 1) {
      await SupaBaseService.client.from("likes").insert({
        "user_id": userId,
        "post_id": postId});
    
    //Add Notification
    await SupaBaseService.client.from("notifications").insert({
      "user_id": userId,
      "notification": "Liked your post",
      "to_user_id": postUserId,
      "post_id": postId
    });

    //Increment the like counter
    await SupaBaseService.client.rpc("like_increment", params: {
      "count": 1, "row_id": postId
    });
  } else{
      await SupaBaseService.client.from("likes").delete().match({
        "user_id" : userId,
        "post_id" : postId
      });
      
      //Decrement post count
      
      await SupaBaseService.client.rpc("like_decrement", params: {
        "count": 1, "row_id": postId
      });
      
      
      
    }
  }




    //To reset thread state
         void resetState(){
                 content.value = "";
                 textEditingController.text = "";
                 image.value = null;
         }


  //   @override
  // void onClose(){
  //     textEditingController.dispose();
  //     super.onClose();
  //   }
}