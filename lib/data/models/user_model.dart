class UserModel{
  String uid;
  String name;
  String username;
  String email;
  String profilePicture;
  int postCount;
  int followerCount;
  int followingCount;
  List<String> posts;

  UserModel({
   required this.uid,
   required this.name,
   required this.username,
   required this.email,
    this.profilePicture ='',
    this.postCount=0,
    this.followerCount=0,
    this.followingCount=0,
    this.posts=const[],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'] ?? '',
      postCount: json['postCount'] ?? 0,
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      posts: List<String>.from(json['posts'] ?? []),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'uid': uid,
  //     'name': name,
  //     'username': username,
  //     'email': email,
  //     'profilePicture': profilePicture,
  //     'postCount': postCount,
  //     'followerCount': followerCount,
  //     'followingCount': followingCount,
  //     'posts': posts,
  //   };
  // }
}