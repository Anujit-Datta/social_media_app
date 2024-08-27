import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/bottom_nav_controller.dart';
import 'package:social_media_app/presentation/controllers/comment_controller.dart';
import 'package:social_media_app/presentation/controllers/like_controller.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/controllers/profile_controller.dart';
import 'package:social_media_app/presentation/controllers/registration_controller.dart';

class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(RegistrationController());
    Get.put(ProfileController());
    Get.put(BottomNavController());
    Get.put(PostController());
    Get.put(CommentController());
    Get.put(LikeController());
  }
}