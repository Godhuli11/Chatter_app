import 'package:flutter/material.dart';
import 'package:my_threads/routes/route.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/services/storage_service.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/theme/theme.dart';
import 'package:my_threads/views/home.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  Get.put(SupaBaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Threads',
      theme: theme,
      getPages: Routes.pages,
       //initialRoute: StorageService.userSession != null ? RouteNames.home : RouteNames.login,
       initialRoute: RouteNames.login ,
    );
  }
}


