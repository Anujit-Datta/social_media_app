import 'package:social_media_app/data/models/user_model.dart';

class Constants {
  static RegExp regExpEmailVerification = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
  static UserModel demoUser = UserModel(
    uid: 'Ggv6C6rP28dDagGyeRwiX5L2K2F2',
    name: 'ABCD Demo',
    username: 'abcddemo',
    email: 'abcddemo@gmail.com',
    profilePicture: 'https://w7.pngwing.com/pngs/748/89/png-transparent-individual-man-people-person-icon-thumbnail.png',
    posts: [],
    postCount: 0,
    followerCount: 0,
    followingCount: 0,
  );
}
