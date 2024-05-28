import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/utils/helper.dart';

import '../models/notification_model.dart';




class NotificationController extends GetxController{
  var loading = false.obs;

  RxList<NotificationModel> notifications = RxList<NotificationModel>();


  void fetchNotifications(String userId) async {
    try{
      loading.value = true;
      final List<dynamic> response = await SupaBaseService.client.from("notifications").select(
          '''
      id,post_id,notification,created_at,user_id,user:user_id(email,metadata)
    ''').eq("to_user_id", userId).order("id",ascending: false);
      loading.value = false;

      if(response.isNotEmpty){
        notifications.value = [for(var item in response) NotificationModel.fromJson
          (item)];
      }
    } catch(e){
         loading.value = false;
         showSnackBar("Error", "Something went wrong . Please try again.!");
    }



  }
}