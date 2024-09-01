import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
import 'package:social_media_app/presentation/controllers/posts_controller.dart';
import 'package:social_media_app/presentation/screens/bottom_nav_bar.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import '../controllers/auth_shared_pref.dart';
import 'log_in_screen.dart';
import 'registration_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool inProgress=true;
  @override
  void initState() {
    loading();
    super.initState();
  }

  loading()async{
    inProgress=true;
    setState(() {});
    String token=await AuthController.getToken();
    await Get.find<PostController>().fetchPosts();
    await Future.delayed(const Duration(seconds: 1)).whenComplete(()async{
      if(token!=''){
        await Get.find<LoginController>().loadSelfProfile().whenComplete((){
          Get.to(()=>const BottomNavBar());
        });
      }
      await Future.delayed(const Duration(seconds: 1));
      inProgress=false;
      setState(() {});
      log('already logged in');
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: !inProgress,
        replacement: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.accentColor,
            size: 50,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appTittle(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              createAccountButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              loginButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton loginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => const LogInScreen());
      },
      child: Text(
        'Login',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.accentColor,
            ),
      ),
    );
  }

  ElevatedButton createAccountButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => const RegistrationScreen());
      },
      child: Text(
        'Create Account',
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }

  Text appTittle() {
    return const Text(
      'SnapShare',
      style: TextStyle(
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster',
      ),
    );
  }
}
