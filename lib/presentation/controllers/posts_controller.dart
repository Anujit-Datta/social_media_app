import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/comment_controller.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
import '../../data/models/post_model.dart';


class PostController extends GetxController{
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  List<Post> postList=[];

  get inProgress => _inProgress;

  likeTap({required int index})async{
    postList[index].isLikedByMe=!postList[index].isLikedByMe;
    update();
    log(AuthController.accessToken);
    if(postList[index].isLikedByMe){
      await _data.collection('Posts').doc(postList[index].id).update({
        'likedBy': FieldValue.arrayUnion([AuthController.accessToken]),
      });
    }else{
      await _data.collection('Posts').doc(postList[index].id).update({
        'likedBy': FieldValue.arrayRemove([AuthController.accessToken]),
      });
    }
  }


  Future<bool> fetchPosts()async{
    bool isSuccess=false;
    _inProgress=true;
    postList.clear();
    update();

    String uid = await AuthController.getToken();
    
    await _data.collection('Posts').get().then((querySnapshot)async{
      for (QueryDocumentSnapshot<Map<String, dynamic>> postSnapshot in querySnapshot.docs) {
        Post post=Post.fromJson(postSnapshot.data());
        post.id=postSnapshot.id;
        List likedBy=List<String>.from(postSnapshot.data()['likedBy']);
        if(likedBy.contains(uid)){
          post.isLikedByMe=true;
        }
        await _data.collection('User').doc(post.postedBy).get().then((docSnapshot){
          Map<String,dynamic>? user=docSnapshot.data();
          if(user!=null){
            post.postedByName=user['name'];
            post.postedByProfilePic=user['profilePicture'];
            log(post.id.toString());
            post.postedByUsername=user['username'];
          }
        });
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