import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/widgets/circle_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
   final TextEditingController textEditingController = TextEditingController(text: "");
   ProfileController controller = Get.find<ProfileController>();
   final SupaBaseService supaBaseService = Get.find<SupaBaseService>();

  @override
  void initState(){
    if(supaBaseService.currentUser.value?.userMetadata?["description"] != null){
      textEditingController.text = supaBaseService.currentUser.value?.userMetadata?["description"];
    }

    super.initState();
  }

   @override
   void dispose(){
    textEditingController.dispose();
    super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     title: const Text("Edit Profile"),
        actions: [
          Obx(
          () => TextButton(onPressed: () {
               controller.updateProfile(supaBaseService.currentUser.value!.id, textEditingController.text);
            },
                child: controller.loading.value ?  SizedBox(height: 14, width: 14,
                child: CircularProgressIndicator(),) :  Text("Done")),
          )
        ],
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
            () => Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleImage(
                   radius: 80,
                   file: controller.image.value,
                    url: supaBaseService.currentUser.value?.userMetadata?["image"],

                 ),
                  IconButton(onPressed: (
                      ) {
                    controller.pickImage();
                  }, icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white60,
                    child: Icon(Icons.edit),
                  ))
                ],
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Your description",
                label: Text("Description"),
              ),
            )
          ],
        ),
      )
    );
  }
}
