import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/profile_controller.dart';
import 'package:social_media_app/presentation/controllers/registration_controller.dart';

class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(RegistrationController());
    Get.put(ProfileController());
  }
}