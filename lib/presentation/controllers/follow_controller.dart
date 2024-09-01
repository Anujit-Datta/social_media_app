import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/profile_controller.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';

class FollowController extends GetxController{
  bool _inProgress=false;

  get inProgress => _inProgress;


  Future<bool> follow({required String uid})async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    String myUid = await AuthController.getToken();
    Get.find<ProfileController>().user.followers.add(myUid);
    try{
      await FirebaseFirestore.instance.collection('User').doc(myUid).update({
        'followings': FieldValue.arrayUnion([uid])
      });
      await FirebaseFirestore.instance.collection('User').doc(uid).update({
        'followers': FieldValue.arrayUnion([myUid])
      });
      isSuccess=true;
    }catch(e){
      snackBar(title: 'Error', message: e.toString(),color: Colors.red);
    }

    _inProgress=false;
    Get.find<ProfileController>().update();
    update();
    return isSuccess;
  }

  Future<bool> unfollow({required String uid})async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    String myUid = await AuthController.getToken();
    Get.find<ProfileController>().user.followers.remove(myUid);
    try{
      await FirebaseFirestore.instance.collection('User').doc(myUid).update({
        'followings': FieldValue.arrayRemove([uid])
      });
      await FirebaseFirestore.instance.collection('User').doc(uid).update({
        'followers': FieldValue.arrayRemove([myUid])
      });
      isSuccess=true;
    }catch(e){
      snackBar(title: 'Error', message: e.toString(),color: Colors.red);
    }

    _inProgress=false;
    Get.find<ProfileController>().update();
    update();
    return isSuccess;
  }

}