import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/add_post_controller.dart';
import 'package:social_media_app/presentation/controllers/bottom_nav_controller.dart';
import 'package:social_media_app/presentation/controllers/comment_controller.dart';
import 'package:social_media_app/presentation/controllers/follow_controller.dart';
import 'package:social_media_app/presentation/controllers/image_picker_controller.dart';
import 'package:social_media_app/presentation/controllers/like_controller.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
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
    Get.put(LoginController());
    Get.put(ImagePickerController());
    Get.put(AddPostController());
    Get.put(FollowController());
  }
}