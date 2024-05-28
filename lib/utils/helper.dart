import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_threads/widgets/confirm_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:jiffy/jiffy.dart';

import 'env.dart';

void showSnackBar ( String title , String message){
    Get.snackbar(title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: const Color(0xff252526),
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
      snackStyle: SnackStyle.GROUNDED,
      margin: const EdgeInsets.all(0.0)
        );
}

//pick image from gallery
Future<File?> pickImageFromGallery() async{
     const uuid = Uuid();
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if(file==null) return null;
    final dir = Directory.systemTemp;
    final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
    File image = await compressImage(File(file.path), targetPath);

    return image;
}


//Compress image file
Future<File> compressImage(File file , String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(file.path, targetPath,quality: 70);
    return File(result!.path);
}

//to get s3 url
String gets3Url (String path){
    return "${ENV.supabaseURL}/storage/v1/object/public/$path";
}


//Confirm Dialog
void  confirmDialog(String title , String text , VoidCallback callBack){
    Get.dialog(ConfirmDialog(
        title: title,
        text: text,
        callBack: callBack,
    ));
}

//Format date
String formatDateFromNow(String date){
    //Parse UTC timestamp to DateTime
    DateTime utcDateTime = DateTime.parse(date.split("+")[0].trim());

    //Convert UTC to IST
    DateTime isDateTime = utcDateTime.add(Duration(hours: 5,minutes: 30));

    //Format Date
    return Jiffy.parseFromDateTime(isDateTime).fromNow();
}
