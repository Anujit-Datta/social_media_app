import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';

import '../controllers/auth_shared_pref.dart';
import '../controllers/login_controller.dart';
import '../screens/initial_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/app_colors.dart';
import '../utils/assets_colors_path.dart';
import 'button_avatar.dart';
import 'logo_text.dart';

AppBar commonAppBar() {
  return AppBar(
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: GetBuilder<LoginController>(
          builder: (ctrl) {
            return ButtonAvatar(
              onTap: () async{
                await AuthController.getToken().then((uid){
                  Get.to(() => ProfileScreen(uid: uid,));
                });
              },
              color: Colors.transparent,
              child: Visibility(
                visible: !ctrl.inProgress,
                replacement: LoadingAnimationWidget.fallingDot(
                  color: AppColors.accentColor,
                  size: 20,
                ),
                child: Visibility(
                  visible: ctrl.selfProfile!=null,
                  replacement: const CircleAvatar(
                    foregroundImage: AssetImage('assets/profile_avater.jpg'),
                  ),
                  child: CircleAvatar(
                      foregroundImage: NetworkImage(ctrl.selfProfile?.profilePicture ??'')
                  ),
                ),
              ),
            );
          }
      ),
    ),
    title: const LogoText(),
    actions: [
      ButtonAvatar(
        onTap: () {},
        color: AssetsColorsPath.iconBackgroundColors,
        child: Icon(
          Icons.notifications_none_outlined,
          size: 28,
        ),
      ),
      const SizedBox(
        width: 2,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonAvatar(
          onTap: () {
            Get.find<LoginController>().logout();
            Get.to(()=>const InitialScreen());
          },
          color: AssetsColorsPath.iconBackgroundColors,
          child: const Icon(
            Icons.logout,
            size: 28,
          ),
        ),
      ),
    ],
  );
}
