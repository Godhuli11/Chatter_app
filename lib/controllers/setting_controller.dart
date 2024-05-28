 import 'package:get/get.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/services/storage_service.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/utils/storage_keys.dart';

class SettingController extends GetxController{


    void logout() async {
     //remove user session from local storage
     StorageService.session.remove(StorageKeys.userSession);
     await SupaBaseService.client.auth.signOut();
     Get.offAllNamed(RouteNames.login);
    }
 }