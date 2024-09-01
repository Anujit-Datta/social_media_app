import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/models/comment_model.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';

import '../../data/models/post_model.dart';

class CommentController extends GetxController{
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  List<Comment> commentsList=[];

  get inProgress => _inProgress;


  Future<bool> fetchCommentsList(String postId)async{
    _inProgress=true;
    bool isSuccess=true;
    commentsList.clear();
    update();

    String uid = await AuthController.getToken();
    
    await _data.collection('Comment').where('postId',isEqualTo: postId).get().then((querySnapshot){
      for (QueryDocumentSnapshot<Map<String, dynamic>> commentSnapshot in querySnapshot.docs) {
        log(commentSnapshot.data().toString());
        Comment comment=Comment.fromJson(commentSnapshot.data());
        comment.likedByMe=comment.likedBy.contains(uid);
        comment.id=commentSnapshot.id;
        commentsList.add(comment);
        log(comment.commentTime.toString());
      }
    });

    _inProgress=false;
    update();
    return isSuccess;
  }

  addComment(String postId,String comment)async{
    String uid = await AuthController.getToken();
    UserModel selfProfile=Get.find<LoginController>().selfProfile!;
    Comment newComment=Comment(
      comment: comment,
      commentedByUid: uid,
      commentedByName: selfProfile.name,
      commentedByProfilePic: selfProfile.profilePicture,
      commentTime: DateTime.now(),
      postId: postId,
      likedBy: [],
    );
    commentsList.add(newComment);
    await _data.collection('Comment').add(newComment.toJson());

    update();
  }

  likeTap({required int index})async{
    commentsList[index].likedByMe=!commentsList[index].likedByMe;
    update();
    log(AuthController.accessToken);
    if(commentsList[index].likedByMe){
      await _data.collection('Comment').doc(commentsList[index].id).update({
        'likedBy': FieldValue.arrayUnion([AuthController.accessToken]),
      });
    }else{
      await _data.collection('Comment').doc(commentsList[index].id).update({
        'likedBy': FieldValue.arrayRemove([AuthController.accessToken]),
      });
    }
  }

}