import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
    );
  }

  TextButton loginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => const LoginScreen());
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
