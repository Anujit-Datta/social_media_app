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
}