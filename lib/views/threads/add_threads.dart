import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/thread_controller.dart';
import 'package:my_threads/services/supabase_service.dart';
import 'package:my_threads/widgets/circle_image.dart';
import 'package:get/get.dart';
import 'package:my_threads/widgets/threads_image_preview.dart';
import '../../widgets/add_threads_appBar.dart';

class AddThread extends StatelessWidget {
   AddThread({Key? key}) : super(key: key);

   final SupaBaseService supaBaseService = Get.find<SupaBaseService>();
   final ThreadController controller = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddThreadAppBar(),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                    Obx(() {
                      final currentUser = supaBaseService.currentUser?.value;
                      return CircleImage(
                        url: currentUser?.userMetadata?["image"] ?? '',
                      );
                    }),
                   SizedBox(width: 10,),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          supaBaseService.currentUser.value!.userMetadata?["name"]
                        ),),
                        TextField(
                          autofocus: true,
                          controller: controller.textEditingController,
                          onChanged: (value) => controller.content.value = value,
                          style: TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: InputDecoration(
                            hintText: "Type a Thread",
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          onTap: ()=> controller.pickImage(),
                          child: Icon(Icons.attach_file),
                        ),

                        //To preview user image
                        Obx(()=>
                           Column(
                             children: [
                               if(controller.image.value != null)
                                     ThreadsImagePreview()
                             ],
                           ),
                        )

                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
