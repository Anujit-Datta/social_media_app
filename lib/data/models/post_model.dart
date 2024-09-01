import 'comment_model.dart';

class Post{
  String? id;
  String postedBy;
  String postedByName;
  String postedByUsername;
  String postedByProfilePic;
  String attachment;
  String caption;
  List<String> likedBy;
  bool isLikedByMe;
  bool isProfilePicture;

  Post({
    required this.postedBy,
    this.postedByName='Name',
    this.postedByUsername='username',
    this.postedByProfilePic='https://firebasestorage.googleapis.com/v0/b/socialmedia-c8dc2.appspot.com/o/profilePictures%2Fprofile_avater.jpg?alt=media&token=e97d4679-6442-43da-a3fb-c700c15386e9',
    required this.attachment,
    required this.caption,
    this.id,
    this.likedBy =const[],
    this.isLikedByMe=false,
    this.isProfilePicture=false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postedBy: json['postedBy'],
      attachment: json['attachment'],
      caption: json['caption'],
      likedBy: List<String>.from(json['likedBy'] ?? []),
      isProfilePicture: json['isProfilePicture'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postedBy': postedBy,
      'attachment': attachment,
      'caption': caption,
      'likedBy': likedBy,
      'isProfilePicture': isProfilePicture,
    };
  }

}