import 'package:flutter/material.dart';
import 'package:my_threads/controllers/setting_controller.dart';
import 'package:get/get.dart';
import 'package:my_threads/utils/helper.dart';

class Setting extends StatelessWidget {
   Setting({Key? key}) : super(key: key);

  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                 confirmDialog(
                   "Are you sure" ,
                   "This action will log you out" ,
                    controller.logout);
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
