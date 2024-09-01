import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';

class ImagePickerController extends GetxController{

  final ImagePicker _picker=ImagePicker();
  XFile? pickedImage;

  pickImageFromGallery()async{
    await _picker.pickImage(source: ImageSource.gallery).then((image){
      pickedImage=image;
      if(image!=null){
        log(image.name);
        update();
      }
    }).catchError((e){
      snackBar(title: 'Error',message: e.toString(),color: Colors.red);
    });
  }

  pickImageFromCamera()async{
    await _picker.pickImage(source: ImageSource.camera).then((image){
      pickedImage=image;
      if(image!=null){
        log(image.name);
        update();
      }
    }).catchError((e){
      snackBar(title: 'Error',message: e.toString(),color: Colors.red);
    });
  }

  clearPickedImage(){
    pickedImage=null;
    update();
  }
}