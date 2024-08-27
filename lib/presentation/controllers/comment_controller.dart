import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/models/comment_model.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';

class CommentController extends GetxController{
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  List<Comment> commentsList=[];

  get inProgress => _inProgress;


  Future<List<Comment>> fetchCommentsList(String postId)async{
    _inProgress=true;
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
    return commentsList;
  }

}