import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';

class ProfileController extends GetxController{
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  bool _isSelfProfile=true;
  UserModel user=UserModel(uid: '', name: 'name', username: 'username', email: 'email');

  get inProgress => _inProgress;
  get isSelfProfile => _isSelfProfile;

  Future<bool> fetchProfileInfo({required String uid,})async{
    bool isSuccess=false;
    _inProgress=true;
    _isSelfProfile=uid==AuthController.accessToken;
    update();
    
    await _data.collection('User').doc(uid).get().then((userDocumentSnapshot){
      if(userDocumentSnapshot.exists){
        log(userDocumentSnapshot.data().toString());
        user = UserModel.fromJson(userDocumentSnapshot.data()!);
        isSuccess=true;
      }
    });

    _inProgress=false;
    update();
    return isSuccess;
  }

}