import 'comment_model.dart';

class Post{
  String? id;
  String postedByName;
  String postedByUsername;
  String postedByProfilePic;
  String attachment;
  String caption;
  List<String> likedBy;
  bool isLikedByMe;
  List<Comment> comments;

  Post({
    required this.postedByName,
    required this.postedByUsername,
    required this.postedByProfilePic,
    required this.attachment,
    required this.caption,
    this.id,
    this.likedBy =const[],
    this.isLikedByMe=false,
    this.comments=const[],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postedByName: json['postedByName'],
      postedByUsername: json['postedByUsername'],
      postedByProfilePic: json['postedByProfilePic'],
      attachment: json['attachment'],
      caption: json['caption'],
      likedBy: List<String>.from(json['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postedByName': postedByName,
      'postedByUsername': postedByUsername,
      'postedByProfilePic': postedByProfilePic,
      'attachment': attachment,
      'caption': caption,
      'likedBy': likedBy,
    };
  }

}