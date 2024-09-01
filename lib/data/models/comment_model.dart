import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  String id;
  String postId;
  String comment;
  String commentedByName;
  String commentedByUid;
  String commentedByProfilePic;
  DateTime commentTime;
  List<String> likedBy;
  bool likedByMe;

  Comment({
    required this.postId,
    required this.comment,
    required this.commentedByName,
    required this.commentedByUid,
    required this.commentedByProfilePic,
    required this.commentTime,
    this.likedBy = const [],
    this.likedByMe=false,
    this.id='',
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      comment: json['comment'],
      commentedByName: json['commentedByName'],
      commentedByUid: json['commentedByUid'],
      commentedByProfilePic: json['commentedByProfilePic'],
      commentTime: json['commentTime'].toDate(),
      likedBy: List<String>.from(json['likedBy'] ?? []),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId':postId,
      'comment': comment,
      'commentedByName': commentedByName,
      'commentedByUid': commentedByUid,
      'commentedByProfilePic': commentedByProfilePic,
      'commentTime': FieldValue.serverTimestamp(),
      'likedBy': likedBy,
    };
  }
}