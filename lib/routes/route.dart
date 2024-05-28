import 'package:get/get.dart';
import 'package:my_threads/routes/routes_name.dart';
import 'package:my_threads/views/Auth/register.dart';
import 'package:my_threads/views/profile/edit_profile.dart';
import 'package:my_threads/views/replies/add_reply.dart';
import 'package:my_threads/views/settings/settings.dart';
import 'package:my_threads/views/threads/show_image.dart';

import '../views/Auth/login.dart';
import '../views/home.dart';
import '../views/threads/show_thread.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(
        name: RouteNames.login,
        page: () => const Login(),
      transition: Transition.fade),
    GetPage(name: RouteNames.register,
        page: () => const Register(),
        transition: Transition.fade),
    GetPage(name: RouteNames.editProfile,
        page: () => const EditProfile(),
        transition: Transition.leftToRight),
    GetPage(name: RouteNames.settings,
        page: () =>  Setting(),
        transition: Transition.rightToLeft),
    GetPage(name: RouteNames.addReply,
        page: () =>  AddReply(),
        transition: Transition.downToUp),
    GetPage(name: RouteNames.showThread,
        page: () =>  ShowThread(),
        transition: Transition.leftToRight),
    GetPage(name: RouteNames.showImage,
        page: () =>  ShowImage(),
        transition: Transition.leftToRight),
  ];
}