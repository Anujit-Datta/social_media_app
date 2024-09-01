import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';
import '../../data/models/post_model.dart';
import 'bottom_nav_controller.dart';

class AddPostController extends GetxController {
  final _data = FirebaseFirestore.instance;
  final storageInstance = FirebaseStorage.instance;
  bool _inProgress = false;
  bool _isProfilePic = false;

  get inProgress => _inProgress;
  get isProfilePic => _isProfilePic;

  Future<bool> addPost({
    required String caption,
    required XFile attachment,
    required bool isProfilePic,
  }) async {
    _inProgress = true;
    bool isSuccess = true;
    String? uid = await AuthController.getToken();
    update();

    await storageInstance.ref().child(_isProfilePic?'profilePictures/${DateTime.now().toString()}${attachment.name}':'uploads/${DateTime.now().toString()}${attachment.name}')
        .putFile(File(attachment.path)).then((task) async {
      await task.ref.getDownloadURL().then((url) async {
        Post post = Post(
          postedBy: uid,
          attachment: url,
          caption: caption,
          isProfilePicture: _isProfilePic,
        );
        await _data.collection('Posts').add(post.toJson()).whenComplete((){
          snackBar(title: 'Success:',message: 'Post Upload Complete.');
          log(post.toJson().toString());
        }).catchError((e){
          snackBar(title: 'Error:',message: e.toString(),color: Colors.red);
          return e;
        });
        await _data.collection('User').doc(uid).set({
          'posts': FieldValue.arrayUnion([url])
        }, SetOptions(merge: true));
        if(_isProfilePic){
          await _data.collection('User').doc(uid).set({
            'profilePicture': url,
          }, SetOptions(merge: true));
        }
            });
    });

    Get.find<PostController>().fetchPosts();
    Get.find<LoginController>().loadSelfProfile();
    Get.find<BottomNavController>().selectedIndexSetter=0;

    _inProgress = false;
    update();
    return isSuccess;
  }

  reverseIsProfilePic(){
    _isProfilePic=!_isProfilePic;
    update();
  }
}
