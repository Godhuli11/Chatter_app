

import 'package:get/get.dart';
import 'package:my_threads/models/post_model.dart';
import 'package:my_threads/models/reply_model.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/utils/env.dart';
import 'dart:io';
import 'package:my_threads/utils/helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ProfileController extends GetxController{
    var loading = false.obs;
     Rx<File?> image = Rx<File?>(null);
     var postLoading = false.obs;
     RxList<PostModel> posts = RxList<PostModel>();
     var replyLoading = false.obs;
     RxList<ReplyModel> replies = RxList<ReplyModel>();

     //Update profile method
    Future<void> updateProfile(String userId , String description ) async {
      try{
          loading.value = true;
          var uploadedPath = "";

          if(image.value != null && image.value!.existsSync()){
            final String dir = "$userId/profile.jpg";
             var path = await SupaBaseService.client.storage.from(ENV.s3Bucket).upload(dir, image.value! ,
             fileOptions: const FileOptions(upsert: true),);
            uploadedPath = path;
          }

          //update profile
        await SupaBaseService.client.auth.updateUser(UserAttributes(
          data : {
            "description" : description,
            "image": uploadedPath.isNotEmpty ? uploadedPath : null,
          }
        ));

          loading.value = false;
          Get.back();
          showSnackBar("Success", "Profile updated successfully !");

      } on StorageException catch(error){
          showSnackBar("Error", error.message);
      } on AuthException catch(error){
        loading.value = false;
        showSnackBar("Error", error.message);
      } catch (error){
        loading.value = false;
        showSnackBar("Error", "Something went wrong . Please try again");
      }
    }

     //Pick the image
   void pickImage() async {
      File? file = await pickImageFromGallery();
      if(file != null) image.value = file;
   }

   //Fetch posts
  void fetchUserThreads(String userId) async {
      try{
        postLoading.value = true;

        final List<dynamic> response = await SupaBaseService.client.from("posts").select(
            '''
          id,content,image,created_at,comment_count,like_count,user_id,
          user:user_id (email,metadata)
        ''').eq("user_id",userId).order("id",ascending: false);
        postLoading.value = false;
        if(response.isNotEmpty){
          posts.value = [for(var item in response) PostModel.fromJson(item)];
        }
      }catch(e){
            postLoading.value = false;
            showSnackBar("Error", "Something went wrong");
      }

  }

  //Fetch Replies
   void fetchReplies(String userId) async{
      try{
        replyLoading.value = true;
        final List<dynamic> response =
        await SupaBaseService.client.from("comments").select(
            ''' id,user_id,post_id,reply,created_at,user:user_id(email,metadata)
          ''').eq("user_id",userId).order("id",ascending: false);
        replyLoading.value = false;
        if(response.isNotEmpty){
            replies.value = [for (var item in response) ReplyModel.fromJson(item)];
        }
      }catch(e){
        replyLoading.value = false;
        showSnackBar("Error", "Something went wrong");
      }

   }
}
