import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/comment_controller.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';

import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';

class PostController extends GetxController{
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  List<Post> postList=[];

  get inProgress => _inProgress;


  Future<bool> fetchPosts()async{
    bool isSuccess=false;
    _inProgress=true;
    postList.clear();
    update();

    String uid = await AuthController.getToken();
    
    await _data.collection('Posts').get().then((querySnapshot)async{
      log(querySnapshot.toString());
      for (QueryDocumentSnapshot<Map<String, dynamic>> postSnapshot in querySnapshot.docs) {
        Post post=Post.fromJson(postSnapshot.data());
        log(post.toString());
        List likedBy=List<String>.from(postSnapshot.data()['likedBy']);
        if(likedBy.contains(uid)){
          post.isLikedByMe=true;
        }
        post.id=postSnapshot.id;
        post.comments=await Get.find<CommentController>().fetchCommentsList(postSnapshot.id);
        postList.add(post);
      }
    }).catchError((e){
      printError();
    });

    _inProgress=false;
    update();
    return isSuccess;
  }


}