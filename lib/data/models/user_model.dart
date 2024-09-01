class UserModel{
  String uid;
  String name;
  String username;
  String email;
  String profilePicture;
  List<String> followers;
  List<String> followings;
  List<String> posts;

  UserModel({
   required this.uid,
   required this.name,
   required this.username,
   required this.email,
    this.profilePicture ='',
    this.followers=const[],
    this.followings=const[],
    this.posts=const[],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'] ?? '',
      posts: List<String>.from(json['posts'] ?? []),
      followers: List<String>.from(json['followers'] ?? []),
      followings: List<String>.from(json['followings'] ?? []),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'posts': posts,
      'followers': followers,
      'followings': followings,
    };
  }
}