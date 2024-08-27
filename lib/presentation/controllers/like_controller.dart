import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';

class LikeController extends GetxController{
  bool _inProgress=false;

  get inProgress => _inProgress;


  Future<bool> isLikedByMe(List<String> likedByList)async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    String uid = await AuthController.getToken();
    if(likedByList.contains(uid)){
      isSuccess=true;
    }

    _inProgress=false;
    update();
    return isSuccess;
  }

}