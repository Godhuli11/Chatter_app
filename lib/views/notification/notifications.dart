import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/notification_controller.dart';
import 'package:get/get.dart';
import 'package:my_threads/services/navigation_service.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/utils/helper.dart';
import 'package:my_threads/widgets/circle_image.dart';

import '../../routes/routes_name.dart';
import '../../widgets/loading.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);


  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());


  @override
  void initState(){
    controller.fetchNotifications(Get.find<SupaBaseService>().currentUser.value!.id);
    super.initState();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.find<NavigationService>().backToPrevPage(),
          icon: Icon(Icons.close),),
        title: const Text("Notification"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.loading.value ? Loading() : Column(
            children: [
              if(controller.notifications.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.notifications.length,
                    itemBuilder: (context,index) => ListTile(
                      onTap: () => {
                        Get.toNamed(RouteNames.showThread,
                        arguments: controller.notifications[index].postId)
                      },
                      leading: CircleImage(
                        url: controller.notifications[index].user?.metadata?.image,
                      ),
                      title: Text(controller.notifications[index].user!.metadata!.name!),
                      trailing: Text(formatDateFromNow(controller.notifications[index].createdAt!)),
                      subtitle:Text(controller.notifications[index].notification!) ,
                    ))
               else
                 Text("No notification found!")
            ],
          ),
        ),
      )
    );
  }
}
